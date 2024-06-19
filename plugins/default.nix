{self, }: {
  perSystem = {
    self',
    pkgs,
  }: {
    legacyPackages.vimPlugins.nobbz = pkgs.callPackage ./nobbz {inherit self;};
  };
}
