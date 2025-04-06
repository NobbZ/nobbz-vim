{
  writers,
  self,
  npins,
  makeWrapper,
}: let
  version = self.rev or self.dirtyRev or "dirty";
in
  writers.writePython3Bin "add-plugin-${version}" {
    makeWrapperArgs = ["--prefix" "PATH" ":" "${npins}"];
  } (builtins.readFile ./add-plugin.py)
