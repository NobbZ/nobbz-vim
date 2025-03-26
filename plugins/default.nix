{self, ...}: {
  perSystem = {
    self',
    pkgs,
    npins,
    lib,
    ...
  }: let
    overrideCheck = _: plugin: plugin.overrideAttrs {doCheck = false;};
    makePluginFromPin = name: pin:
      pkgs.vimUtils.buildVimPlugin {
        pname = name;
        version = pin.version or pin.revision;
        src = pin;
      };
    optionalPlugins = {
      # mandatory plugins (aka start)
      catppuccin = false;
      lz-n = false;
      promis-async = false;
      which-key = false;
      # optional plugins (aka opt)
      augment = true;
      lspsaga = true;
      nvim-ufo = true;
      startuptime = true;
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
      (lib.mapAttrs overrideCheck)
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
