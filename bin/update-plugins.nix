{
  lib,
  writers,
  self,
  npins,
  git,
}: let
  version = self.rev or self.dirtyRev or "dirty";

  path = lib.makeBinPath [npins git];
in
  writers.writePython3Bin "update-plugins-${version}" {
    makeWrapperArgs = ["--prefix" "PATH" ":" path];
  } (builtins.readFile ./update-plugins.py)
