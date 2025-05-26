{self, ...}: {
  perSystem = {
    self',
    pkgs,
    npins,
    lib,
    ...
  }: let
    makePluginFromPin = name: pin:
      pkgs.vimUtils.buildVimPlugin {
        pname = name;
        version = pin.version or pin.revision;
        src = pin;
        doCheck = false;
      };
    optionalPlugins = {
      # TODO: finish them to be properly sorted in, eager loading them for now.
      fix-cursor = false;
      gitsigns = false;
      indent-blankline = false;
      lspconfig = false;
      lspkind = false;
      luasnip = false;
      # mandatory plugins (aka start)
      catppuccin = false;
      lz-n = false;
      nio = false;
      noice = false;
      none-ls = false;
      notify = false;
      nui = false;
      plenary = false;
      precognition = false;
      promis-async = false;
      rainbow = false;
      telescope = false;
      telescope-ui-select = false;
      which-key = false;
      # optional plugins (aka opt)
      augment = true;
      crates = true;
      flash = true;
      ledger = true;
      lspsaga = true;
      markdown = true;
      mini = true;
      nabla = true;
      nvim-ufo = true;
      startuptime = true;
      surround = true;
      trouble = true;
    };
    applyOptional = name: plugin: {
      inherit plugin;
      optional = optionalPlugins.${name} or (lib.warn "${name} has no explicit optionality, assuming mandatory status" false);
    };
    plugins = lib.pipe npins [
      (lib.filterAttrs (name: _: lib.hasPrefix "nvim-" name))
      (lib.mapAttrs' (name: pin: lib.nameValuePair (lib.removePrefix "nvim-" name) pin))
      (lib.mapAttrs makePluginFromPin)
      (lib.mapAttrs applyOptional)
    ];
  in {
    legacyPackages.vimPlugins =
      {
        nobbz = pkgs.callPackage ./nobbz {inherit self;};
        nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
      }
      // plugins;
  };
}
