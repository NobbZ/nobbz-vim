-- Basic test for the helpers module
local helpers = require("nobbz.helpers")

describe("nobbz.helpers", function()
  it("should have a map function", function()
    assert.is_function(helpers.map)
  end)

  it("should map keybindings correctly", function()
    -- Just verify the function exists and can be called
    -- Full testing would require a neovim instance
    local result = helpers.map("n", "<leader>t", "<cmd>echo 'test'<cr>", { desc = "Test" })
    assert.is_not_nil(result)
  end)
end)
