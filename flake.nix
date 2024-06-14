{
  outputs = {
    self,
    parts,
    ...
  } @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      perSystem = {
        self',
        pkgs,
        npins,
        ...
      }: {
        _module.args.npins = import ./npins;

        formatter = pkgs.writeShellScriptBin "formatter" ''
          ${pkgs.lib.getExe pkgs.alejandra} .
          ${pkgs.lib.getExe pkgs.stylua} --indent-type Spaces --indent-width 2 .
        '';

        packages.neovim = pkgs.callPackage ./nvim.nix {inherit npins self';};
        packages.default = self'.packages.neovim;

        legacyPackages.vimPlugins.nobbz = pkgs.callPackage ./plugins/nobbz {inherit self;};

        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues {
            inherit (pkgs) nil stylua;
            inherit (self'.packages) neovim;
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?reg=nixpkgs-unstable";

    parts.url = "github:hercules-ci/flake-parts";
  };
}
