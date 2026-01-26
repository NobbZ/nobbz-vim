{
  outputs = {
    self,
    parts,
    ...
  } @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.treefmt-nix.flakeModule
        ./bin
        ./nix
        ./plugins
      ];

      perSystem = {
        self',
        pkgs,
        npins,
        inputs',
        ...
      }: {
        _module.args.npins = import ./npins;

        packages.md-oxide = pkgs.callPackage ./pkgs/oxide.nix {inherit npins;};
        packages.default = pkgs.symlinkJoin {
          name = self'.packages.nobbzvim.name;
          paths = [self'.packages.nobbzvim self'.packages.nobbzvide];
          meta.mainProgram = self'.packages.nobbzvim.meta.mainProgram;
        };

        devShells.default = let
          emmy-lua-code-style = inputs'.nixpkgs-emmy.legacyPackages.emmy-lua-code-style.overrideAttrs (_: {
            src = npins.emmy-style;
          });
        in
          pkgs.mkShell {
            packages = builtins.attrValues {
              inherit (pkgs) nil stylua npins alejandra basedpyright;
              inherit (self'.packages) nobbzvim nobbzvide;
              inherit emmy-lua-code-style;
            };

            shellHook = let
              luarc = pkgs.mk-luarc-json {
                nvim = self'.packages.nobbzvim.config.neovim;
                plugins = self'.packages.nobbzvim.config.plugins.start ++ self'.packages.nobbzvim.config.plugins.opt;
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

    mnw.url = "github:gerg-l/mnw";

    parts.url = "github:hercules-ci/flake-parts";
    parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    wrapper-manager.url = "github:viperml/wrapper-manager";

    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    gen-luarc.inputs.nixpkgs.follows = "nixpkgs";
    gen-luarc.inputs.flake-parts.follows = "parts";
  };
}
