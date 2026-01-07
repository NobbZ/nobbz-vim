-- Example test demonstrating busted testing patterns
-- This file serves as a template for adding new tests

describe("Example Test Suite", function()
  -- Setup that runs before each test in this describe block
  before_each(function()
    -- Initialize test state here
  end)

  -- Cleanup that runs after each test in this describe block
  after_each(function()
    -- Clean up test state here
  end)

  describe("Basic Assertions", function()
    it("should demonstrate equality assertions", function()
      local expected = 42
      local actual = 42
      assert.equals(expected, actual)
    end)

    it("should demonstrate boolean assertions", function()
      assert.is_true(true)
      assert.is_false(false)
      assert.is_nil(nil)
      assert.is_not_nil("something")
    end)

    it("should demonstrate table assertions", function()
      local table1 = { a = 1, b = 2, }
      local table2 = { a = 1, b = 2, }
      assert.same(table1, table2)
    end)
  end)

  describe("Mocking Examples", function()
    it("should demonstrate function mocking", function()
      -- Save original function
      local original_func = some_module.some_function

      -- Replace with mock
      some_module.some_function = function()
        return "mocked value"
      end

      -- Test code that uses the mocked function
      -- local result = code_under_test()
      -- assert.equals("expected", result)

      -- Restore original
      some_module.some_function = original_func
    end)

    it("should demonstrate vim API mocking", function()
      -- When testing code that uses vim APIs, mock them like this:
      _G.vim = {
        fn = {
          executable = function() return 1 end,
        },
        api = {
          nvim_create_autocmd = function() end,
        },
      }

      -- Now test your code that uses vim.fn or vim.api
    end)
  end)

  describe("Testing Module Exports", function()
    it("should verify module returns expected interface", function()
      -- For a module that exports functions:
      -- local module = require("module_name")
      -- assert.is_function(module.some_function)
      -- assert.is_not_nil(module.some_value)
    end)
  end)

  describe("Error Handling", function()
    it("should test that errors are raised", function()
      assert.has_error(function()
        error("This should fail")
      end)
    end)

    it("should test error messages", function()
      assert.error_matches(function()
        error("Expected error message")
      end, "Expected error")
    end)
  end)
end)
