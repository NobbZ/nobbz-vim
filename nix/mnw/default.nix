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

  plugins.dev.nobbz = {
    pure = "${inputs.self}/plugins/nobbz";
    impure = ''/' .. os.getenv(\"NOBBZ_VIM_DEV_ROOT\") .. ${"'"}'';
  };

  plugins.start = lib.mkMerge [
    # Please revise this list
    (builtins.attrValues {
      inherit
        (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
        lspconfig
        lspkind
        luasnip
        ;
      inherit (pkgs.vimPlugins) lualine-nvim blink-cmp bigfile-nvim oil-nvim nvim-web-devicons vim-wakatime;
      nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    })
    # Start because needed like that
    (builtins.attrValues {
      inherit
        (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
        SchemaStore
        lz-n
        noice
        none-ls
        notify
        nui
        promis-async
        rainbow
        telescope
        telescope-ui-select
        which-key
        ;
    })
  ];

  plugins.opt = builtins.attrValues {
    inherit
      (inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vimPlugins)
      catppuccin
      crates
      flash
      gitsigns
      indent-blankline
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
    inherit (pkgs.vimPlugins) neogit;
  };
}
