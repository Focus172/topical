const std = @import("std");

fn usage() void {
    std.debug.print(
        \\builder srcdir outdir
        \\
        \\Example:
        \\builder content/ public/
    , .{});
}

const TEMPLATE = @embedFile("template.html");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();
    const a = gpa.allocator();

    const argv = std.os.argv;
    if (argv.len < 3) {
        usage();
        return;
    }

    const srcdir = argv[1];
    const outdir = argv[2];

    var src = try std.fs.cwd().openDirZ(srcdir, .{ .iterate = true });
    defer src.close();
    var out = try std.fs.cwd().openDirZ(outdir, .{});
    defer out.close();

    try iteraterDir(a, src, out);
}

fn iteraterDir(a: std.mem.Allocator, src: std.fs.Dir, out: std.fs.Dir) !void {
    // TODO: check file timestamps and only remake the html if the source changed

    var iter = src.iterate();
    while (try iter.next()) |file| {
        if (file.kind == .directory) {
            var newsrc = try src.openDir(file.name, .{ .iterate = true });
            defer newsrc.close();

            var newout = blk: {
                break :blk out.openDir(file.name, .{}) catch {
                    break :blk try out.makeOpenPath(file.name, .{});
                };
            };
            defer newout.close();

            try iteraterDir(a, newsrc, newout);

            continue;
        }

        std.debug.assert(file.kind == .file);
        if (!std.mem.eql(u8, file.name[file.name.len - 3 ..], ".md")) {
            std.debug.print("not a markdown file ({s}), copying instead\n", .{file.name});
            try std.fs.Dir.copyFile(src, file.name, out, file.name, .{});
            continue;
        }

        const sf = try src.openFile(file.name, .{});
        defer sf.close();

        var buffer = std.ArrayList(u8).init(a);
        defer buffer.deinit();

        try sf.reader().readAllArrayList(&buffer, std.math.maxInt(usize));

        const content = buffer.items;

        // --------------------------------------------------

        const name = blk: {
            var nameiter = std.mem.splitScalar(u8, file.name, '.');
            break :blk nameiter.next().?;
        };

        const newname = try std.fmt.allocPrint(a, "{s}.html", .{name});
        defer a.free(newname);

        const of = try out.createFile(newname, .{});
        defer of.close();

        const html = try mardownToHtml(a, content);
        defer a.free(html);

        const writer = of.writer();

        try std.fmt.format(writer, TEMPLATE, .{ name, html });
    }
}

fn mardownToHtml(a: std.mem.Allocator, markdown: []const u8) ![]u8 {
    var html = std.ArrayList(u8).init(a);
    defer html.deinit();

    const args: []const []const u8 = &.{ "pandoc", "-f", "markdown", "-t", "html" };

    var pandoc = std.ChildProcess.init(args, a);
    pandoc.stdin_behavior = .Pipe;
    pandoc.stdout_behavior = .Pipe;

    try pandoc.spawn();

    var stdin = pandoc.stdin.?;
    pandoc.stdin = null;
    try stdin.writeAll(markdown);
    stdin.close();

    var stdout = pandoc.stdout.?;
    pandoc.stdout = null;
    defer stdout.close();

    var buf: [1024]u8 = undefined;
    while (true) {
        const read = try stdout.read(&buf);
        if (read == 0) break;
        try html.appendSlice(buf[0..read]);
    }

    _ = try pandoc.wait();

    return html.toOwnedSlice();
}
