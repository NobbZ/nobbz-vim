-- Basic test for the helpers module
local helpers = require("nobbz.helpers")

describe("nobbz.helpers", function()
  it("should have a git_root function", function()
    assert.is_function(helpers.git_root)
  end)

  it("should return git root or nil", function()
    -- Just verify the function exists and can be called
    -- Full testing would require a git repository
    local result = helpers.git_root()
    -- Result can be string or nil
    assert.is_true(type(result) == "string" or result == nil)
  end)
end)
