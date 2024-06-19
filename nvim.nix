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
      inherit (self'.legacyPackages.vimPlugins) nobbz telescope lspconfig cmp-nvim-lsp;
      inherit (vimPlugins) null-ls-nvim nvim-cmp which-key-nvim luasnip;
      inherit (vimPlugins) lspkind-nvim indent-blankline-nvim markdown-nvim onedark-nvim lualine-nvim;
      inherit (vimPlugins) lualine-lsp-progress neogit oil-nvim nvim-web-devicons;
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
