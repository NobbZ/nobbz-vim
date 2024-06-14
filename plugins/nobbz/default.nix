{
  vimUtils,
  self,
}:
vimUtils.buildVimPlugin {
  pname = "nobbz";
  version = self.shortRev or self.dirtyRev or "dirty";

  # TODO: use filesets or something similar to filter out unwanted files
  src = "${self}/plugins/nobbz";
}
