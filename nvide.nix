{
  neovide,
  self',
  inputs,
  pkgs,
  lib,
}:
(inputs.wrapper-manager.lib {
  inherit pkgs;
  modules = [
    {
      wrappers.neovide.basePackage = neovide;
      wrappers.neovide.prependFlags = ["--neovim-bin" (lib.getExe self'.packages.neovim) "--fork"];
    }
  ];
})
.config
.build
.packages
.neovide
