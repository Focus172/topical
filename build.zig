const std = @import("std");

fn iteraterDir(
    b: *std.Build,
    src: struct { fs: std.fs.Dir, lazy: std.Build.LazyPath },
    out: []const u8,
    template: std.Build.LazyPath,
) !void {
    var iter = src.fs.iterate();
    while (try iter.next()) |file| {
        if (file.kind == .directory) {
            var nextDir = try src.fs.openDir(file.name, .{ .iterate = true });
            defer nextDir.close();

            const nextLzy = src.lazy.path(b, file.name);

            const newOut = try std.fmt.allocPrint(b.allocator, "{s}/{s}", .{ out, file.name });
            defer b.allocator.free(newOut);

            try iteraterDir(b, .{ .fs = nextDir, .lazy = nextLzy }, newOut, template);

            continue;
        }

        std.debug.assert(file.kind == .file);

        if (file.name.len < 3 or !std.mem.eql(u8, file.name[file.name.len - 3 ..], ".md")) {
            const newname = try std.fmt.allocPrint(b.allocator, "{s}/{s}", .{ out, file.name });
            defer b.allocator.free(newname);

            const installFile = b.addInstallFile(src.lazy.path(b, file.name), newname);
            b.getInstallStep().dependOn(&installFile.step);

            // std.debug.print("cant translate {s} yet\n", .{file.name});
            continue;
        }

        // pandoc -s -f markdown -t html --template template.html -o OUTPUT INPUT

        const index = std.mem.lastIndexOfScalar(u8, file.name, '.') orelse {
            std.debug.print("cant translate {s} yet\n", .{file.name});
            continue;
        };
        const name = file.name[0..index];

        const newname = try std.fmt.allocPrint(b.allocator, "{s}/{s}.html", .{ out, name });
        defer b.allocator.free(newname);

        const pandoc = b.addSystemCommand(&.{ "pandoc", "-s", "-f", "markdown", "-t", "html" });
        pandoc.addArg("--template");
        pandoc.addFileArg(template);
        pandoc.addArg("-o");
        const output = pandoc.addOutputFileArg(newname);

        pandoc.addFileArg(src.lazy.path(b, file.name));

        const installFile = b.addInstallFile(output, newname);
        b.getInstallStep().dependOn(&installFile.step);
    }
}

pub fn build(b: *std.Build) void {
    // _ = b.standardTargetOptions(.{});
    // _ = b.standardOptimizeOption(.{});

    // const contentArg = b.option([]const u8, "input", "path to dir containing content") orelse "content";
    const contentArg = "content";

    const contentL = b.path(contentArg);

    var contentD = std.fs.openDirAbsolute(contentL.getPath(b), .{ .iterate = true }) catch unreachable;
    defer contentD.close();

    const template = b.path("template.html");

    iteraterDir(
        b,
        .{ .fs = contentD, .lazy = contentL },
        ".",
        template,
    ) catch unreachable;

    // const run_cmd = b.addRunArtifact(exe);
    // run_cmd.step.dependOn(b.getInstallStep());
    // if (b.args) |args| run_cmd.addArgs(args);
    //
    // const run_step = b.step("run", "Run the app");
    // run_step.dependOn(&run_cmd.step);
}
