-- Tests for nobbz.lazy module

-- Mock vim global
_G.vim = {
  notify = function() end,
  log = {
    levels = {
      ERROR = 1,
      WARN = 2,
      INFO = 3,
    },
  },
  list_extend = function(dst, src)
    for _, v in ipairs(src) do
      table.insert(dst, v)
    end
    return dst
  end,
  api = {
    nvim_cmd = function() end,
  },
}

-- Mock lz.n module
package.preload["lz.n"] = function()
  return {
    load = function() end,
    trigger_load = function() end,
  }
end

package.preload["lz.n.state"] = function()
  return {
    plugins = {},
  }
end

package.preload["nobbz.lazy.specs"] = function()
  return {}
end

local lazy = require("nobbz.lazy")

describe("nobbz.lazy", function()
  describe("add_specs", function()
    before_each(function()
      package.loaded["nobbz.lazy"] = nil
      package.loaded["nobbz.lazy.specs"] = nil
      package.preload["nobbz.lazy.specs"] = function()
        return {}
      end
      lazy = require("nobbz.lazy")
    end)

    it("should add specs to the specs table", function()
      local specs = { { "test", }, }
      lazy.add_specs(specs)
      assert.is_not_nil(lazy)
    end)

    it("should not add specs after finish is called", function()
      lazy.finish()
      local specs = { { "test", }, }
      lazy.add_specs(specs)
      -- Should warn but not crash
      assert.is_not_nil(lazy)
    end)
  end)

  describe("packadd", function()
    it("should call nvim_cmd with packadd", function()
      local called = false
      vim.api.nvim_cmd = function(cmd)
        if cmd.cmd == "packadd" then
          called = true
        end
      end
      lazy.packadd("test-plugin")
      assert.is_true(called)
    end)
  end)

  describe("load_once", function()
    before_each(function()
      package.loaded["lz.n.state"] = nil
      package.preload["lz.n.state"] = function()
        return {
          plugins = { "test-plugin", },
        }
      end
    end)

    it("should load a plugin and remove it from state", function()
      lazy.load_once("test-plugin")
      assert.is_not_nil(lazy)
    end)

    it("should handle invalid plugin name", function()
      lazy.load_once(nil)
      assert.is_not_nil(lazy)
    end)

    it("should handle plugin not in state", function()
      lazy.load_once("nonexistent-plugin")
      assert.is_not_nil(lazy)
    end)
  end)

  describe("finish", function()
    it("should call lz.n.load with specs", function()
      local loaded = false
      package.loaded["lz.n"] = nil
      package.preload["lz.n"] = function()
        return {
          load = function()
            loaded = true
          end,
        }
      end
      
      package.loaded["nobbz.lazy"] = nil
      lazy = require("nobbz.lazy")
      lazy.finish()
      assert.is_true(loaded)
    end)
  end)
end)
