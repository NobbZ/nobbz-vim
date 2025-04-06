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
      wrappers.neovide.flags = ["--neovim-bin" (lib.getExe self'.packages.neovim)];
    }
  ];
})
.config
.build
.packages
.neovide
