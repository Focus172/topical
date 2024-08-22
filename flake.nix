{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }: let
    lib = nixpkgs.lib;
    systems = [ "aarch64-linux" "x86_64-linux" ];
    eachSystem = f: lib.foldAttrs lib.mergeAttrs { } (map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s)) systems);
  in
    eachSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.stdenv.mkDerivation {
          pname = "scurvyless";
          version = "0.1.0";

          nativeBuildInputs = with pkgs; [ pandoc ];
          buildInputs = with pkgs; [ ];

          src = ./.;

          # shellHook = ''export VIMRUNTIME=$PWD/runtime'';

          meta = {
            maintainers = ["Evan Stokdyk <evan.stokdyk@gmail.com>"];
            description = "A Website for the Honorable Seas";
          };
        };
      });
}

