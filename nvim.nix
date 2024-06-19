{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  npins,
  vimPlugins,
  self',
  lib,
  lua-language-server,
  stylua,
}: let
  neovim-nightly = neovim-unwrapped.overrideAttrs {
    src = npins.neovim;
    version = npins.neovim.revision;
    patches = [];
    preConfigure = ''
      sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
    '';
  };

  config = neovimUtils.makeNeovimConfig {
    plugins = builtins.attrValues ({
        inherit (vimPlugins) null-ls-nvim;
        inherit (vimPlugins) indent-blankline-nvim markdown-nvim onedark-nvim lualine-nvim;
        inherit (vimPlugins) lualine-lsp-progress neogit oil-nvim nvim-web-devicons;
      }
      // self'.legacyPackages.vimPlugins);
  };
in
  (wrapNeovimUnstable neovim-nightly config).overrideAttrs (old: {
    generatedWrapperArgs =
      old.generatedWrapperArgs
      or []
      ++ [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath (
          builtins.attrValues {
            #
            # Runtime dependencies
            #
            inherit lua-language-server stylua;
          }
        ))
      ];
  })
