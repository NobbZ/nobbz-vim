{self, ...}: {
  perSystem = {self', pkgs, ...}: {
    packages = {
      addPlugin = pkgs.callPackage ./add-plugin.nix {inherit self;};
    };

    apps.add-plugin.program = self'.packages.addPlugin;
  };
}
