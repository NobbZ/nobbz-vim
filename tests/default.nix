{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    checks = {
      # Lua unit tests using busted
      lua-tests = pkgs.stdenv.mkDerivation {
        name = "lua-tests";
        src = ./.;
        nativeBuildInputs = [
          pkgs.lua5_1
          pkgs.luajitPackages.busted
        ];
        buildPhase = ''
          # For now, just verify the test files exist and are valid Lua
          echo "Checking Lua test files..."
          for test in tests/lua/*_spec.lua; do
            if [ -f "$test" ]; then
              echo "Found test: $test"
              ${pkgs.lua5_1}/bin/luac -p "$test" || exit 1
            fi
          done
        '';
        installPhase = ''
          mkdir -p $out
          echo "Lua tests validated" > $out/result
        '';
      };

      # Integration tests that run nvim
      integration-tests = pkgs.stdenv.mkDerivation {
        name = "integration-tests";
        src = ./.;
        nativeBuildInputs = [
          pkgs.bash
          pkgs.coreutils
          self'.packages.neovim
        ];
        buildPhase = ''
          mkdir -p $out
          
          export HOME=$TMPDIR
          export XDG_CONFIG_HOME=$TMPDIR/.config
          export XDG_DATA_HOME=$TMPDIR/.local/share
          export XDG_STATE_HOME=$TMPDIR/.local/state
          export XDG_CACHE_HOME=$TMPDIR/.cache
          
          echo "Running integration tests..."
          
          # Test 1: nvim starts and quits
          echo "Test 1: Basic startup..."
          if timeout 30 ${self'.packages.neovim}/bin/nvim --headless +qa; then
            echo "✓ Test 1 passed"
          else
            echo "✗ Test 1 failed"
            exit 1
          fi
          
          # Test 2: Can create and edit a file
          echo "Test 2: File editing..."
          TMP_FILE=$(mktemp --suffix=.txt)
          if timeout 30 ${self'.packages.neovim}/bin/nvim --headless "$TMP_FILE" \
            +'normal iHello, World!' \
            +wq; then
            if grep -q "Hello, World!" "$TMP_FILE"; then
              echo "✓ Test 2 passed"
            else
              echo "✗ Test 2 failed: Content not written"
              exit 1
            fi
          else
            echo "✗ Test 2 failed: Could not edit file"
            exit 1
          fi
          
          # Test 3: Health check runs
          echo "Test 3: Health check..."
          if timeout 30 ${self'.packages.neovim}/bin/nvim --headless +'checkhealth nobbz' +qa 2>&1 | tee $TMPDIR/health.log; then
            echo "✓ Test 3 passed"
          else
            echo "✗ Test 3 failed"
            cat $TMPDIR/health.log
            exit 1
          fi
        '';
        installPhase = ''
          mkdir -p $out
          echo "Integration tests passed" > $out/result
        '';
      };
    };
  };
}
