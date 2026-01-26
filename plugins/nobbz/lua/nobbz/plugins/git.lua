-- disable line breaks in gitcommit mode (it is annoying!)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

-- register keys for neogit
WK.add({
  { "<leader>g",  group = "git", },
  { "<leader>gb", group = "blame", },
})

require("nobbz.health").register_program("git", true)

require("nobbz.lazy").add_specs({ {
  "gitsigns",
  after = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup()

    WK.add({
      { "<leader>gb",  group = "blame", },
      { "<leader>gbb", gitsigns.blame, },
      { "<leader>gbi", function() gitsigns.blame_line({ full = true, }) end, },
      { "<leader>gbl", gitsigns.toggle_current_line_blame, },
      { "<leader>gw",  gitsigns.toggle_word_diff, },
    })
  end,
  keys = {
    { "<leader>gbb", desc = "open file blame", },
    { "<leader>gbi", desc = "show blame info", },
    { "<leader>gbl", desc = "toggle current line blame", },
    { "<leader>gw",  desc = "toggle word diff", },
  },

}, {
  "neogit",
  after = function()
    local neogit = require("neogit")

    neogit.setup({})
  end,
  keys = {
    { "<leader>gg", "<cmd>:Neogit<cr>", desc = "Neogit status", },
  },
  ft = { "gitcommit", },
}, })
