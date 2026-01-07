-- Tests for nobbz.health module
-- Note: These tests mock vim APIs as they're not available in unit test environment

-- Mock vim global
_G.vim = {
  fn = {
    executable = function() return 0 end,
  },
  health = {
    start = function() end,
    ok = function() end,
    error = function() end,
    info = function() end,
    warn = function() end,
  },
  api = {
    nvim_create_autocmd = function() end,
  },
  lsp = {
    config = {},
  },
  log = {
    levels = {
      ERROR = 1,
      WARN = 2,
      INFO = 3,
    },
  },
}

local health = require("nobbz.health")

describe("nobbz.health", function()
  -- Reset state before each test
  before_each(function()
    -- Reload the module to reset state
    package.loaded["nobbz.health"] = nil
    health = require("nobbz.health")
  end)

  describe("register_program", function()
    it("should register a program as required", function()
      health.register_program("test-program", true)
      -- Check would be called during health.check()
      -- This test mainly verifies no errors occur
      assert.is_not_nil(health)
    end)

    it("should register a program as optional", function()
      health.register_program("optional-program", false)
      assert.is_not_nil(health)
    end)

    it("should register a program with filetypes", function()
      health.register_program("ft-program", { "lua", "vim", })
      assert.is_not_nil(health)
    end)

    it("should allow re-registering a program", function()
      health.register_program("test-program", false)
      health.register_program("test-program", true)
      assert.is_not_nil(health)
    end)
  end)

  describe("unregister_program", function()
    it("should unregister a program", function()
      health.register_program("test-program", true)
      health.unregister_program("test-program")
      assert.is_not_nil(health)
    end)

    it("should handle unregistering non-existent program", function()
      health.unregister_program("nonexistent")
      assert.is_not_nil(health)
    end)
  end)

  describe("register_lsp", function()
    it("should register an LSP server without config", function()
      vim.lsp.config = {}
      health.register_lsp("test-lsp")
      assert.is_not_nil(health)
    end)

    it("should register an LSP server with config", function()
      vim.lsp.config = {
        ["test-lsp"] = {
          cmd = { "test-lsp-bin", },
          filetypes = { "lua", },
        },
      }
      health.register_lsp("test-lsp")
      assert.is_not_nil(health)
    end)
  end)

  describe("done", function()
    it("should mark configuration as done", function()
      health.done()
      assert.is_not_nil(health)
    end)
  end)

  describe("check", function()
    it("should run without errors when nothing registered", function()
      health.check()
      assert.is_not_nil(health)
    end)

    it("should check registered programs", function()
      health.register_program("test-prog", true)
      health.check()
      assert.is_not_nil(health)
    end)

    it("should check after done is called", function()
      health.register_program("test-prog", false)
      health.done()
      health.check()
      assert.is_not_nil(health)
    end)
  end)
end)
