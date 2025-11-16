{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  vimPlugins,
  self',
  lib,
  nodejs,
  lua-language-server,
  stylua,
  markdown-oxide,
  xclip,
}: let
  config = neovimUtils.makeNeovimConfig {
    plugins = builtins.attrValues ({
        inherit (vimPlugins) lualine-nvim blink-cmp bigfile-nvim;
        inherit (vimPlugins) neogit oil-nvim nvim-web-devicons vim-wakatime;
      }
      // self'.legacyPackages.vimPlugins);
  };
in
  (wrapNeovimUnstable neovim-unwrapped config).overrideAttrs (old: {
    generatedWrapperArgs =
      old.generatedWrapperArgs
      or []
      ++ [
        # This is needed to be able to point `startuptime` at the correct
        # nvim binary, it checks the unwrapped nvim otherwise
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
