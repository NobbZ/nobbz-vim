{
  lib,
  inputs,
  ...
}: {
  flake.overlays.nvim = final: prev: {
    nobbzvim =
      inputs.mnw.lib.wrap {
        pkgs = final;
        inherit inputs;
      }
      ./mnw;
  };
  flake.overlays.nvide = final: prev: {
    nobbzvide =
      (inputs.wrapper-manager.lib {
        pkgs = final;
        modules = [
          {
            wrappers.neovide.basePackage = final.neovide;
            wrappers.neovide.prependFlags = ["--neovim-bin" (lib.getExe final.nobbzvim) "--fork"];
          }
        ];
      }).config.build.packages.neovide;
  };

  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    _module.args.pkgs = builtins.foldl' (p: o: p.extend o) inputs'.nixpkgs.legacyPackages [
      inputs.self.overlays.nvim
      inputs.self.overlays.nvide
      inputs.gen-luarc.overlays.default
    ];

    packages.nobbzvim = pkgs.nobbzvim;
    packages.nobbzvide = pkgs.nobbzvide;
  };
}
