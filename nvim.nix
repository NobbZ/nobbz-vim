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
  markdown-oxide,
  xclip,
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
        inherit (vimPlugins) onedark-nvim lualine-nvim;
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
        "--set"
        "NOBBZ_NVIM_PATH"
        "${placeholder "out"}/bin/nvim"
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath (
          builtins.attrValues {
            #
            # Runtime dependencies
            #
            inherit lua-language-server stylua markdown-oxide xclip;
          }
        ))
      ];
  })
