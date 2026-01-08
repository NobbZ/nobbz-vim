# Tests

This directory contains tests for the nobbz-vim configuration.

## Structure

- `lua/` - Lua unit tests for individual modules
- `integration/` - Integration tests that run nvim in different scenarios
- `default.nix` - Nix flake module that defines test checks

## Running Tests

Tests are run through the Nix flake's check system:

```bash
# Run all checks (includes tests, builds, etc.)
nix flake check

# Run only Lua unit tests
nix build .#checks.x86_64-linux.lua-tests

# Run only integration tests
nix build .#checks.x86_64-linux.integration-tests
```

## Writing Tests

### Lua Unit Tests

Lua unit tests are written using the [busted](https://olivinelabs.com/busted/) framework.
Create files with the `_spec.lua` suffix in the `lua/` directory.

Example:
```lua
describe("my module", function()
  it("should do something", function()
    assert.is_true(true)
  end)
end)
```

### Integration Tests

Integration tests are bash scripts that test nvim behavior in realistic scenarios.
They should test things like:
- Startup and shutdown
- Plugin loading
- LSP functionality
- File editing

Create executable bash scripts in the `integration/` directory.

## CI/CD

Tests are automatically run on pull requests through GitHub Actions workflows
defined in `.github/workflows/`. These workflows are generated from CUE definitions
in the `cicd/` directory.
