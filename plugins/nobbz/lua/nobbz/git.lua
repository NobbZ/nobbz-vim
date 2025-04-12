local gitsigns = require("gitsigns")
local neogit = require("neogit")

neogit.setup({})

-- disable line breaks in gitcommit mode (it is annoying!)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

-- register keys for neogit
WK.add({
  { "<leader>g",   group = "git", },
  { "<leader>gg",  "<cmd>:Neogit<cr>",                                   desc = "Neogit status", },
  { "<leader>gb",  group = "blame", },
  { "<leader>gbb", gitsigns.blame,                                       desc = "open file blame", },
  { "<leader>gbi", function() gitsigns.blame_line({ full = true, }) end, desc = "show blame info", },
  { "<leader>gbl", gitsigns.toggle_current_line_blame,                   desc = "toggle current line blame", },
  { "<leader>gw",  gitsigns.toggle_word_diff,                            desc = "toggle word diff", },
})

gitsigns.setup()
