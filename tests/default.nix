{
  self',
  pkgs,
  lib,
  ...
}: let
  # Test runner that will be available in the test environment
  testRunner = pkgs.writeTextFile {
    name = "test-runner.lua";
    text = builtins.readFile ./test-runner.lua;
  };

  # Test initialization script
  testInit = pkgs.writeTextFile {
    name = "test.lua";
    text = ''
      -- Add test runner to package path
      vim.opt.runtimepath:prepend("${testRunner}")
      
      -- Load the main configuration
      require("nobbz")
      
      -- Wait for config to fully load
      vim.defer_fn(function()
        -- Run the test suite
        local test_runner = dofile("${testRunner}")
        test_runner.run()
      end, 100)
    '';
  };
in {
  perSystem = {
    checks = {
      nvim-config-loads = pkgs.runCommand "nvim-config-loads" {
        nativeBuildInputs = [self'.packages.neovim];
      } ''
        # Run neovim headless and check if config loads without errors
        export HOME=$(mktemp -d)
        nvim --headless -c "lua vim.print('Config loaded successfully')" -c "quitall" 2>&1 | tee $out
        
        # Check if there were any errors
        if grep -qi "error" $out; then
          echo "Configuration loaded with errors!"
          exit 1
        fi
        
        echo "success" >> $out
      '';

      nvim-health-check = pkgs.runCommand "nvim-health-check" {
        nativeBuildInputs = [self'.packages.neovim];
      } ''
        # Run neovim health check
        export HOME=$(mktemp -d)
        nvim --headless -c "checkhealth nobbz" -c "write! $out" -c "quitall" 2>&1
        
        # Verify output exists
        if [ ! -f "$out" ]; then
          echo "Health check failed to produce output"
          exit 1
        fi
        
        # Check for critical errors in health check
        if grep -i "ERROR" $out; then
          echo "Health check found errors:"
          cat $out
          exit 1
        fi
        
        echo "Health check passed"
      '';

      nvim-lua-tests = pkgs.runCommand "nvim-lua-tests" {
        nativeBuildInputs = [self'.packages.neovim];
      } ''
        # Run Lua test suite
        export HOME=$(mktemp -d)
        nvim --headless -u ${testInit} 2>&1 | tee $out
        
        # Check if tests passed
        if grep -q "FAILED" $out; then
          echo "Tests failed!"
          cat $out
          exit 1
        fi
        
        if ! grep -q "ALL TESTS PASSED" $out; then
          echo "Tests did not complete successfully!"
          cat $out
          exit 1
        fi
        
        echo "success" >> $out
      '';
    };
  };
}
