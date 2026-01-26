{
  pkgs,
  lib,
  inputs,
  ...
}: {
  aliases = ["vi" "vim" "nobbzvim"];
  appName = "nobbz-vim";
  desktopEntry = false;
  enable = true;
  extraBinPath = builtins.attrValues {
    inherit (pkgs) lua-language-server stylua markdown-oxide vscode-json-languageserver yaml-language-server taplo wl-clipboard xclip;
  };
  # `startuptime` needs to be pointed to the *correct* neovim, therefore we provide a full binarypath here
  wrapperArgs = ["--set" "NOBBZ_NVIM_PATH" "${placeholder "out"}/bin/nvim"];

  plugins.startAttrs.nobbz = {
    src = "${inputs.self}/plugins/nobbz";
  };

  plugins.start = lib.mkMerge [
    # Please revise this list
    (builtins.attrValues {
      inherit
        (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
        fix-cursor
        gitsigns
        indent-blankline
        lspconfig
        lspkind
        luasnip
        ;
      inherit (pkgs.vimPlugins) lualine-nvim blink-cmp bigfile-nvim neogit oil-nvim nvim-web-devicons vim-wakatime;
      nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    })
    # Start because needed like that
    (builtins.attrValues {
      inherit
        (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
        catppuccin
        lz-n
        nio
        noice
        none-ls
        notify
        nui
        plenary
        promis-async
        rainbow
        SchemaStore
        telescope
        telescope-ui-select
        which-key
        ;
    })
  ];

  plugins.opt = builtins.attrValues {
    inherit
      (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
      crates
      flash
      ledger
      lspsaga
      markdown
      mini
      nabla
      nvim-ufo
      startuptime
      surround
      trouble
      ;
  };
}
