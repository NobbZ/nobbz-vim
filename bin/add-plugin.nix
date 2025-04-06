{
  lib,
  writers,
  self,
  npins,
}: let
  version = self.rev or self.dirtyRev or "dirty";

  path = lib.makeBinPath [npins];
in
  writers.writePython3Bin "add-plugin-${version}" {
    makeWrapperArgs = ["--prefix" "PATH" ":" path];
  } (builtins.readFile ./add-plugin.py)
