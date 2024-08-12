{
  writeShellApplication,
  lib,
  elixir,
  self,
}: let
  version = self.rev or self.dirtyRev or "dirty";
in
  writeShellApplication {
    name = "update-nvim-${version}";

    text = ''
      ${lib.getExe' elixir "elixir"} ${./update-nvim.exs}
    '';
  }
