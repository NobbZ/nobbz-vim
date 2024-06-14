{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  npins,
  vimPlugins,
}: let
  nvim-treesitter = vimPlugins.nvim-treesitter.withAllGrammars;

  neovim-nightly = neovim-unwrapped.overrideAttrs {
    src = npins.neovim;
    version = __trace (__attrNames npins.neovim) npins.neovim.revision;
    patches = [];
    preConfigure = ''
      sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
    '';
  };

  config = neovimUtils.makeNeovimConfig {
    plugins = [
      nvim-treesitter
    ];
  };
in
  wrapNeovimUnstable neovim-nightly config
