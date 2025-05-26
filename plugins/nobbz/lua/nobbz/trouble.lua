---Flag to track whether virtual diagnostic lines are enabled
---@type boolean
local virtual_lines = false

---Toggles the display of virtual diagnostic lines in the editor
---
---This function switches between showing diagnostics inline (as virtual text)
---or not showing them at all. It updates the vim.diagnostic configuration
---accordingly.
local function toggle_virtual_lines()
  virtual_lines = not virtual_lines
  vim.diagnostic.config({ virtual_lines = virtual_lines, })
end

WK.add({
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "toggle trouble", },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "toggle buffer trouble", },
  { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)", },
  { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
  { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)", },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)", },
  { "<leader>xc", toggle_virtual_lines,                                         desc = "toggle virtual lines", },
})

require("nobbz.lazy").add_specs({
  {
    "trouble",
    cmd = "Trouble",
    after = function()
      require("trouble.config").setup({
        focus = true, -- autofocus on open
      })
    end,
  },
})
