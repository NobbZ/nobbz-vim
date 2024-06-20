{
  outputs = {
    self,
    parts,
    ...
  } @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [./plugins];

      perSystem = {
        self',
        pkgs,
        npins,
        ...
      }: {
        _module.args.npins = import ./npins;

        formatter = pkgs.writeShellScriptBin "formatter" ''
          export PATH=${pkgs.lib.makeBinPath [pkgs.alejandra pkgs.stylua]}:$PATH
          alejandra .
          stylua .
        '';

        packages.md-oxide = pkgs.callPackage ./pkgs/oxide.nix {inherit npins;};
        packages.neovim = pkgs.callPackage ./nvim.nix {inherit npins self';};
        packages.default = self'.packages.neovim;

        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues {
            inherit (pkgs) nil stylua npins alejandra;
            inherit (self'.packages) neovim;
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    parts.url = "github:hercules-ci/flake-parts";
    parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };
}
