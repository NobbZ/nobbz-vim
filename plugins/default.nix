{self, ...}: {
  perSystem = {
    self',
    pkgs,
    npins,
    lib,
    ...
  }: let
    pluginPins = lib.filterAttrs (name: _: lib.hasPrefix "nvim-" name) npins;
    plugins = lib.traceVal (
      lib.mapAttrs' (name: pin: {
        name = lib.removePrefix "nvim-" name;
        value = pkgs.vimUtils.buildVimPlugin {
          pname = name;
          version = pin.version or pin.revision;
          src = pin;
        };
      })
      pluginPins);
  in {
    legacyPackages.vimPlugins =
      {
        nobbz = pkgs.callPackage ./nobbz {inherit self;};
      }
      // plugins;
  };
}
