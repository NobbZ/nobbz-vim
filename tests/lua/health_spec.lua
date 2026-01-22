-- Basic test for the health module
local health = require("nobbz.health")

describe("nobbz.health", function()
  it("should have a register_program function", function()
    assert.is_function(health.register_program)
  end)

  it("should have a register_lsp function", function()
    assert.is_function(health.register_lsp)
  end)

  it("should register programs correctly", function()
    health.register_program("test-program")
    -- Just verify it doesn't error
    assert.is_true(true)
  end)

  it("should register LSPs correctly", function()
    health.register_lsp("test-lsp")
    -- Just verify it doesn't error
    assert.is_true(true)
  end)
end)
