{
  description = "A Website for the Honorable Seas";

  inputs.nixpkgs.url = "nixpkgs"; # use the system nixpkgs if not locked

  outputs = { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      systems = [ "aarch64-linux" "x86_64-linux" ];
      eachSystem = f:
        lib.foldAttrs lib.mergeAttrs { }
        (map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s)) systems);
    in eachSystem (system:
      let 
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (final: prev: { }) ];
      };
      in {
        devShells.default = pkgs.stdenv.mkDerivation {
          name = "scurvyless";
          nativeBuildInputs = with pkgs; [ pandoc zig rsync python3 ];
          buildInputs = with pkgs; [ ];

          # shellHook = '''';

          meta = {
            maintainers = [ "Evan Stokdyk <evan.stokdyk@gmail.com>" ];
            description = "A Website for the Honorable Seas";
          };
        };
      }
      );
}

