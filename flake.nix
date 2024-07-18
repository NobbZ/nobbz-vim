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
        inputs',
        ...
      }: {
        _module.args.npins = import ./npins;
        _module.args.pkgs = inputs'.nixpkgs.legacyPackages.extend inputs.gen-luarc.overlays.default;

        formatter = pkgs.writeShellScriptBin "formatter" ''
          export PATH=${pkgs.lib.makeBinPath [pkgs.alejandra inputs'.nixpkgs-emmy.legacyPackages.emmy-lua-code-style]}:$PATH
          alejandra .
          CodeFormat format -w . -ig .direnv -c ${self}/.editorconfig
        '';

        packages.md-oxide = pkgs.callPackage ./pkgs/oxide.nix {inherit npins;};
        packages.neovim = pkgs.callPackage ./nvim.nix {inherit npins self';};
        packages.default = self'.packages.neovim;

        devShells.default = let
          emmy-lua-code-style = inputs'.nixpkgs-emmy.legacyPackages.emmy-lua-code-style.overrideAttrs (_: {
            src = npins.emmy-style;
          });
        in
          pkgs.mkShell {
            packages = builtins.attrValues {
              inherit (pkgs) nil stylua npins alejandra;
              inherit (self'.packages) neovim;
              inherit emmy-lua-code-style;
            };

            shellHook = let
              luarc = pkgs.mk-luarc-json {
                nvim = self'.packages.neovim.unwrapped;
                plugins = self'.packages.neovim.packpathDirs.myNeovimPackages.start;
              };
            in
              /*
              bash
              */
              ''
                ln -fs ${luarc} .luarc.json
              '';
          };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    nixpkgs-emmy.url = "github:NixOS/nixpkgs?ref=pull/323401/head";

    parts.url = "github:hercules-ci/flake-parts";
    parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    gen-luarc.inputs.nixpkgs.follows = "nixpkgs";
    gen-luarc.inputs.flake-parts.follows = "parts";
  };
}
