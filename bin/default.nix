{self, ...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      add-plugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
      update-nvim = pkgs.callPackage ./update-nvim.nix {inherit self;};
      update-plugins = pkgs.callPackage ./update-plugins.nix {inherit self;};
    };

    checks = {
      add-plugin = self'.packages.add-plugin;
      update-nvim = self'.packages.update-nvim;
      update-plugins = self'.packages.update-plugins;
    };
  };
}
