-- Minimal test configuration that loads the main nobbz config
-- This is used as the init file for headless test runs

-- Load the main configuration
require("nobbz")

-- Wait for config to fully load
vim.defer_fn(function()
  -- Run the test suite
  require("test-runner").run()
end, 100)
