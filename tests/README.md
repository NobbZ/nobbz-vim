# Neovim Integration Tests

This directory contains automated integration tests for the Neovim configuration.

## Test Structure

Tests are implemented as Nix derivations that run Neovim in headless mode. The tests are defined in `default.nix` and exposed via the flake's `checks` output.

## Available Tests

### 1. nvim-config-loads
Basic smoke test that verifies the configuration loads without errors.

```bash
nix build .#checks.x86_64-linux.nvim-config-loads
```

### 2. nvim-health-check
Runs `:checkhealth nobbz` to verify all programs and LSP configurations are correctly set up.

```bash
nix build .#checks.x86_64-linux.nvim-health-check
```

### 3. nvim-lua-tests
Runs a comprehensive Lua-based test suite that checks:
- Configuration loads completely
- Health check module is available
- LSP configurations are registered
- Lazy loading system works
- Key plugins are loaded
- Helper modules are available

```bash
nix build .#checks.x86_64-linux.nvim-lua-tests
```

## Running All Tests

```bash
nix flake check
```

## Test Implementation

Tests use `pkgs.runCommand` to create derivations that:
1. Set up a temporary HOME directory
2. Run Neovim in headless mode with specific commands
3. Capture output and verify success/failure
4. Exit with appropriate status codes

The Lua test runner (`test-runner.lua`) provides a simple test framework that:
- Runs individual test functions with `pcall` for error handling
- Tracks pass/fail status
- Prints results and summary
- Exits with status code 0 on success, 1 on failure

## Adding New Tests

To add a new test:

1. Add a new derivation in `tests/default.nix` under the `checks` attribute
2. Use the existing tests as a template
3. Ensure the test exits with status code 0 on success
4. Update this README with the new test

For Lua-based tests, add test cases in `test-runner.lua` using the `test()` function.
