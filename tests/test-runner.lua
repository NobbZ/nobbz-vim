-- Test runner for headless neovim tests
-- This file loads the main config and runs various integration tests

local M = {}

local test_count = 0
local pass_count = 0

---Run a test and record its result
---@param name string Test name
---@param test_fn function Test function that returns boolean or throws error
local function test(name, test_fn)
  test_count = test_count + 1
  local success, result = pcall(test_fn)

  if success and result ~= false then
    pass_count = pass_count + 1
    print(string.format("✓ %s", name))
  else
    local error_msg = result
    if type(result) == "boolean" then error_msg = "Test returned false" end
    print(string.format("✗ %s: %s", name, error_msg))
  end
end

---Run all integration tests
M.run = function()
  print("=== Running Neovim Integration Tests ===")
  print("")

  -- Test 1: Configuration loads without errors
  test("Config loads without errors", function()
    -- If we got here, config loaded successfully
    return true
  end)

  -- Test 2: Health check module is available
  test("Health check module is available", function()
    local health = require("nobbz.health")
    return health ~= nil and type(health.check) == "function"
  end)

  -- Test 3: LSP configurations are registered
  test("LSP configurations are registered", function()
    local lsp_config = vim.lsp.config
    return lsp_config ~= nil and next(lsp_config) ~= nil
  end)

  -- Test 4: Lazy loading system is available
  test("Lazy loading system is available", function()
    local lazy = require("nobbz.lazy")
    return lazy ~= nil and type(lazy.add_specs) == "function"
  end)

  -- Test 5: Key global variables are set
  test("Key global variables are set", function()
    return WK ~= nil and LSP_CAPAS ~= nil
  end)

  -- Test 6: Core plugins are loaded
  test("Core plugins are loaded", function()
    local blink = require("blink.cmp")
    local telescope = require("telescope")
    return blink ~= nil and telescope ~= nil
  end)

  -- Test 7: Helpers module is available
  test("Helpers module is available", function()
    local helpers = require("nobbz.helpers")
    return helpers ~= nil
  end)

  -- Print summary
  print("")
  print("=== Test Summary ===")
  print(string.format("Total: %d", test_count))
  print(string.format("Passed: %d", pass_count))
  print(string.format("Failed: %d", test_count - pass_count))
  print("")

  if pass_count == test_count then
    print("ALL TESTS PASSED")
    vim.cmd.quitall()
  else
    print("TESTS FAILED")
    vim.cmd.cquit()
  end
end

return M
