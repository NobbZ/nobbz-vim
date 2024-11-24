vim.o.timeout = true
vim.o.timeoutlen = 1000 -- this needs to be a high value to unbreak `surround`.
-- TODO: 👆 once the which-key issue has been resolved, lower it back to 300ms
-- https://github.com/kylechui/nvim-surround/issues/354

WK.setup({})

WK.add({
  { "<c-w>", "<Up>",    mode = { "v", "n", "i", }, },
  { "<c-a>", "<Left>",  mode = { "v", "n", "i", }, },
  { "<c-s>", "<Down>",  mode = { "v", "n", "i", }, },
  { "<c-d>", "<Right>", mode = { "v", "n", "i", }, },
})
