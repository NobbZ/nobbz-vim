{self, ...}: {
  perSystem = {
    self',
    pkgs,
    npins,
    lib,
    ...
  }: let
    # Test runner script
    testRunner = pkgs.writeShellScriptBin "run-lua-tests" ''
      export LUA_PATH="${placeholder "out"}/?.lua;${placeholder "out"}/?/init.lua;;"
      ${pkgs.luajitPackages.busted}/bin/busted \
        --verbose \
        --output=tap \
        --pattern=_spec.lua \
        "$@"
    '';

    # Build the test package
    luaTests = pkgs.stdenv.mkDerivation {
      name = "nobbz-vim-tests";
      src = ../.;

      nativeBuildInputs = [
        pkgs.luajitPackages.busted
      ];

      phases = ["unpackPhase" "checkPhase" "installPhase"];

      # Copy source files and tests
      unpackPhase = ''
        cp -r $src/tests tests
        cp -r $src/plugins/nobbz/lua lua
      '';

      # Run the tests
      checkPhase = ''
        export LUA_PATH="./?.lua;./?/init.lua;;"
        ${pkgs.luajitPackages.busted}/bin/busted \
          --verbose \
          --output=tap \
          --pattern=_spec.lua \
          tests/
      '';

      installPhase = ''
        mkdir -p $out/share
        echo "Tests passed" > $out/share/test-results.txt
        
        # Install test infrastructure for reuse
        mkdir -p $out/bin
        ln -s ${testRunner}/bin/run-lua-tests $out/bin/
      '';

      meta = {
        description = "Lua unit tests for nobbz-vim";
        mainProgram = "run-lua-tests";
      };
    };
  in {
    packages.lua-tests = luaTests;
    packages.test-runner = testRunner;

    checks.lua-tests = luaTests;
  };
}
