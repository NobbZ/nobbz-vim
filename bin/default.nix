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

    apps = {
      add-plugin.program = self'.packages.addPlugin;
      update-nvim.program = self'.packages.updateNvim;
      update-plugins.program = self'.packages.updatePlugins;
    };

    checks = {
      addPlugin = self'.packages.addPlugin;
      updateNvim = self'.packages.updateNvim;
      updatePlugins = self'.packages.updatePlugins;
    };
  };
}
