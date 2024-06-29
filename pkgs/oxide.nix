{
  rustPlatform,
  npins,
}: let
  shortRev = builtins.substring 0 8 npins.markdown-oxide.revision;
in
  rustPlatform.buildRustPackage {
    pname = "markdown-oxide";
    version = npins.markdown-oxide.revision;

    src = npins.markdown-oxide;

    postPatch = ''
      sed -i 's|^version = "\(.*\)"$|version = "\1+g${shortRev}"|' Cargo.toml
    '';

    cargoLock = {
      lockFile = "${npins.markdown-oxide}/Cargo.lock";
      outputHashes."tower-lsp-0.20.0" = "sha256-QRP1LpyI52KyvVfbBG95LMpmI8St1cgf781v3oyC3S4=";
    };
  }
