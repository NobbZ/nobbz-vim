{self, ...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      add-plugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
      update-plugins = pkgs.callPackage ./update-plugins.nix {inherit self;};
    };

    checks = {
      add-plugin = self'.packages.add-plugin;
      update-plugins = self'.packages.update-plugins;
    };
  };
}
