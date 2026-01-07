{self, ...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages = {
      add-plugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
      update-plugins = pkgs.callPackage ./update-plugins.nix {inherit self;};
      run-tests = pkgs.callPackage ./run-tests.nix {inherit self;};
    };

    apps = {
      run-tests = {
        type = "app";
        program = "${self'.packages.run-tests}/bin/run-tests";
      };
    };

    checks = {
      add-plugin = self'.packages.add-plugin;
      update-plugins = self'.packages.update-plugins;
    };
  };
}
