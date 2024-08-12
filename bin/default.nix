{self, ...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      addPlugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
      updatePlugins = pkgs.callPackage ./update-plugins.nix {inherit self;};
    };

    apps.add-plugin.program = self'.packages.addPlugin;
    apps.update-plugins.program = self'.packages.updatePlugins;

    checks.addPlugin = self'.packages.addPlugin;
    checks.updatePlugins = self'.packages.updatePlugins;
  };
}
