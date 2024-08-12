{self, ...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      addPlugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
      updateNvim = pkgs.callPackage ./update-nvim.nix {inherit self;};
      updatePlugins = pkgs.callPackage ./update-plugins.nix {inherit self;};
    };

    apps.add-plugin.program = self'.packages.addPlugin;
    apps.update-nvim.program = self'.packages.updateNvim;
    apps.update-plugins.program = self'.packages.updatePlugins;

    checks.addPlugin = self'.packages.addPlugin;
    checks.updateNvim = self'.packages.updateNvim;
    checks.updatePlugins = self'.packages.updatePlugins;
  };
}
