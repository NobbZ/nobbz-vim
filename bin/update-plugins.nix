{
  writeShellApplication,
  self,
  npins,
  git,
}: let
  version = self.rev or self.dirtyRev or "dirty";
in
  writeShellApplication {
    name = "add-plugin-${version}";

    runtimeInputs = [npins git];

    text = builtins.readFile ./add-plugin.sh;
  }
