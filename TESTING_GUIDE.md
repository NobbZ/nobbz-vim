# Testing Guide for nobbz-vim

This guide explains how to work with the testing infrastructure in this repository.

## Quick Start

```bash
# Run all tests (recommended before committing)
nix run .#run-tests

# Or run specific test suites
nix build .#checks.x86_64-linux.lua-tests
nix build .#checks.x86_64-linux.integration-tests

# Run everything (tests + builds + checks)
nix flake check
```

## Test Types

### 1. Lua Unit Tests (`tests/lua/`)

These tests validate individual Lua modules and their interfaces.

**Current tests:**
- `health_spec.lua` - Tests for the health check system
- `helpers_spec.lua` - Tests for helper utilities
- `lazy_spec.lua` - Tests for lazy loading system

**Writing new tests:**
```lua
-- tests/lua/mymodule_spec.lua
local mymodule = require("nobbz.mymodule")

describe("nobbz.mymodule", function()
  it("should have a function", function()
    assert.is_function(mymodule.my_function)
  end)
  
  it("should return expected value", function()
    assert.equals(42, mymodule.my_function())
  end)
end)
```

### 2. Integration Tests (`tests/integration/`)

These tests run neovim in headless mode to test real behavior.

**Current tests:**
- `test-startup.sh` - Tests nvim starts, health checks pass, files can be edited
- `test-lsp.sh` - Tests LSP functionality

**Writing new tests:**
```bash
#!/usr/bin/env bash
set -euo pipefail

NVIM=${1:-nvim}

echo "Testing: My feature..."
if timeout 30 $NVIM --headless +"MyCommand" +qa; then
  echo "✓ Test passed"
else
  echo "✗ Test failed"
  exit 1
fi
```

## Running Tests Locally

### Prerequisites

- Nix with flakes enabled
- This repository cloned locally

### Running Individual Tests

```bash
# Lua tests only
nix build .#checks.x86_64-linux.lua-tests --print-build-logs

# Integration tests only
nix build .#checks.x86_64-linux.integration-tests --print-build-logs

# Build package (validates it builds)
nix build .#neovim --print-build-logs

# Run all checks (includes tests)
nix flake check --print-build-logs
```

### Using the Test Runner

The test runner script provides colored output and runs all tests:

```bash
nix run .#run-tests
```

This will:
1. Build the neovim package
2. Run Lua unit tests
3. Run integration tests
4. Run flake checks

If any step fails, it exits immediately with an error.

## CI/CD Integration

Tests run automatically on every pull request via GitHub Actions.

### Workflows

**pull-check.yml** - Main test workflow
- Runs on: Pull requests
- Jobs:
  - `build_flake` - Builds neovim package
  - `build_checks` - Runs `nix flake check`
  - `lua_tests` - Runs Lua unit tests
  - `integration_tests` - Runs integration tests

**check-generated.yml** - Verifies workflow files
- Runs on: Pull requests
- Ensures generated workflows match CUE definitions

### Viewing CI Results

1. Go to your PR on GitHub
2. Scroll to the bottom to see status checks
3. Click "Details" next to any check to see logs
4. All checks must pass before merging

## Debugging Failed Tests

### Lua Tests

If Lua tests fail:
1. Check the build log: `nix build .#checks.x86_64-linux.lua-tests --print-build-logs`
2. Look for syntax errors or failed assertions
3. Fix the module or update the test

### Integration Tests

If integration tests fail:
1. Check the build log: `nix build .#checks.x86_64-linux.integration-tests --print-build-logs`
2. Look for timeout or command failures
3. Test interactively: `nix run .#neovim` to launch nvim
4. Check health: `:checkhealth nobbz` inside nvim

### CI Failures

If CI fails but local tests pass:
1. Check the GitHub Actions logs
2. Look for environment differences
3. Ensure you've committed all necessary files
4. Check that workflows are up-to-date: `just check`

## Best Practices

### When to Add Tests

- **Always** when adding new Lua modules
- When fixing bugs (add test that would have caught the bug)
- When adding new features
- When refactoring (tests ensure behavior unchanged)

### Test Guidelines

1. **Keep tests simple** - Test one thing at a time
2. **Use descriptive names** - Test names should explain what they test
3. **Don't test implementation** - Test behavior, not internals
4. **Make tests fast** - Slow tests won't get run
5. **Clean up** - Tests should not affect the system

### Before Committing

Always run tests before committing:

```bash
# Quick check
nix run .#run-tests

# Full check (recommended)
nix flake check
```

## Adding New Tests

### For Lua Modules

1. Create `tests/lua/modulename_spec.lua`
2. Write tests using the busted-style syntax
3. Run: `nix build .#checks.x86_64-linux.lua-tests`
4. Commit the test file

### For Integration Scenarios

1. Create `tests/integration/test-feature.sh`
2. Make it executable: `chmod +x tests/integration/test-feature.sh`
3. Test manually: `./tests/integration/test-feature.sh $(nix build .#neovim --print-out-paths --no-link)/bin/nvim`
4. It will be picked up automatically by the integration test runner
5. Commit the test file

## Troubleshooting

**Problem:** Tests fail locally but I haven't changed anything
- Solution: Update flake: `nix flake update`

**Problem:** Integration tests timeout
- Solution: Increase timeout in the test script or check if nvim hangs

**Problem:** Can't run tests, Nix not found
- Solution: Install Nix: https://nixos.org/download.html

**Problem:** Make commands fail
- Solution: Enter dev shell: `nix develop` (includes cue, alejandra, etc.)

## Getting Help

- Check `IMPLEMENTATION_SUMMARY.md` for technical details
- Read `tests/README.md` for test-specific documentation
- Check `cicd/README.md` for workflow generation
- Ask in issues or discussions
