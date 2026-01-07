# Lua Unit Tests

This project includes unit tests for the Lua configuration modules using [busted](https://lunarmodules.github.io/busted/).

## Running Tests

### Using Nix

The recommended way to run tests is using Nix:

```bash
# Run all tests
nix build .#checks.x86_64-linux.lua-tests

# Run tests manually via the test package
nix build .#lua-tests

# Run tests in development
nix develop
busted tests/
```

### Test Structure

Tests are located in the `tests/` directory and follow the naming convention `*_spec.lua`:

- `helpers_spec.lua` - Tests for utility helper functions
- `health_spec.lua` - Tests for the health check system
- `lazy_spec.lua` - Tests for the lazy loading system

### Writing Tests

Tests use the busted framework with BDD-style assertions:

```lua
describe("module name", function()
  describe("function name", function()
    it("should do something", function()
      local result = module.function()
      assert.equals(expected, result)
    end)
  end)
end)
```

### Coverage

Tests cover:
- Core utility functions (helpers.lua)
- Health check registration and execution (health.lua)
- Lazy loading plugin system (lazy/init.lua)

### Mocking

Since these tests run outside of Neovim, vim APIs are mocked using Lua tables. See individual test files for examples.

## Future Improvements

- Add tests for more modules (lsp configurations, plugin configs)
- Add code coverage reporting
- Integrate with CI/CD if GitHub Actions is set up
- Add property-based testing for complex functions
