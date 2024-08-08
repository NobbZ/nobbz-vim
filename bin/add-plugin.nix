{writeShellApplication, self, npins}:
let
  version = self.rev or self.dirtyRev or "dirty";
in
writeShellApplication {
  name = "add-plugin-${version}";
  
  runtimeInputs = [npins];

  text = builtins.readFile ./add-plugin.sh;
}
