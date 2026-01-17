-- Tests for nobbz.helpers module
local helpers = require("nobbz.helpers")

describe("nobbz.helpers", function()
  describe("git_root", function()
    it("should return nil when not in a git repository", function()
      -- Mock io.popen to return empty result
      local old_popen = io.popen
      io.popen = function()
        return {
          read = function() return "" end,
          close = function() end,
        }
      end

      local result = helpers.git_root()
      assert.is_nil(result)

      io.popen = old_popen
    end)

    it("should return nil when io.popen fails", function()
      local old_popen = io.popen
      io.popen = function()
        return nil
      end

      local result = helpers.git_root()
      assert.is_nil(result)

      io.popen = old_popen
    end)

    it("should return trimmed git root path", function()
      local old_popen = io.popen
      io.popen = function()
        return {
          read = function() return "/path/to/repo\n  " end,
          close = function() end,
        }
      end

      local result = helpers.git_root()
      assert.equals("/path/to/repo", result)

      io.popen = old_popen
    end)

    it("should handle paths without trailing whitespace", function()
      local old_popen = io.popen
      io.popen = function()
        return {
          read = function() return "/path/to/repo" end,
          close = function() end,
        }
      end

      local result = helpers.git_root()
      assert.equals("/path/to/repo", result)

      io.popen = old_popen
    end)
  end)
end)
