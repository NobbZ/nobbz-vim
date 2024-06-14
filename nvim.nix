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
  nvim-treesitter = vimPlugins.nvim-treesitter.withAllGrammars;

  neovim-nightly = neovim-unwrapped.overrideAttrs {
    src = npins.neovim;
    version = npins.neovim.revision;
    patches = [];
    preConfigure = ''
      sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
    '';
  };

  config = neovimUtils.makeNeovimConfig {
    plugins = builtins.attrValues {
      inherit (self'.legacyPackages.vimPlugins) nobbz;
      inherit (vimPlugins) null-ls-nvim nvim-lspconfig cmp-nvim-lsp nvim-cmp which-key-nvim luasnip;
      inherit (vimPlugins) lspkind-nvim indent-blankline-nvim;
      inherit nvim-treesitter;
    };
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
