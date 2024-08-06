{self, ...}: {
  perSystem = {self', pkgs, ...}: {
    packages = {
      addPlugin = pkgs.callPackage ./add-plugin.nix {};
    };

    apps.add-plugin.program = self'.packages.addPlugin;
  };
}
