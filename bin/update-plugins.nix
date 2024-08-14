{
  writeShellApplication,
  self,
  npins,
  git,
}: let
  version = self.rev or self.dirtyRev or "dirty";
in
  writeShellApplication {
    name = "update-plugin-${version}";

    runtimeInputs = [npins git];

    text = builtins.readFile ./update-plugins.sh;
  }
