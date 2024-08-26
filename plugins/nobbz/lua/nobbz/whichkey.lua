vim.o.timeout = true
vim.o.timeoutlen = 300

WK.setup({})

WK.add({
  { "<c-w>", "<Up>",    mode = { "v", "n", "i", }, },
  { "<c-a>", "<Left>",  mode = { "v", "n", "i", }, },
  { "<c-s>", "<Down>",  mode = { "v", "n", "i", }, },
  { "<c-d>", "<Right>", mode = { "v", "n", "i", }, },
})
