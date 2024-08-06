{writeShellApplication}:

writeShellApplication {
  name = "add-plugin";
  
  runtimeInputs = [];

  text = builtins.readFile ./add-plugin.sh;
}
