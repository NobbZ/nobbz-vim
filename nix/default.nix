{
  lib,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    treefmt = {
      projectRootFile = "flake.nix";

      programs.alejandra.enable = true;
      programs.black.enable = true;
      programs.mdformat.enable = true;
      programs.mypy.enable = true;
      programs.oxfmt.enable = true;
      programs.shellcheck.enable = true;
      programs.toml-sort.enable = true;

      programs.mdformat.settings.number = true;

      settings.formatter.emmy.command = pkgs.writeShellScriptBin "emmy-fmt" ''
        for f in $@; do
          ${lib.getExe inputs'.nixpkgs-emmy.legacyPackages.emmy-lua-code-style} format -w . -ig .direnv -c ${inputs.self}/.editorconfig -f $f
        done
      '';
      settings.formatter.emmy.includes = ["*.lua"];
      settings.on-unmatched = "warn";
      settings.excludes = [
        ".editorconfig"
        ".github/*.md"
        ".opencode/agent/*.md"
      ];
    };
  };
}
