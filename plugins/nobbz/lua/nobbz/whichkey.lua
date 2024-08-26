vim.o.timeout = true
vim.o.timeoutlen = 300

WK.setup({})

WK.add({
  { "w",     "<Up>",    mode = { "v", "n", }, },
  { "a",     "<Left>",  mode = { "v", "n", }, },
  { "s",     "<Down>",  mode = { "v", "n", }, },
  { "d",     "<Right>", mode = { "v", "n", }, },
  { "<c-w>", "<Up>",    mode = "i", },
  { "<c-a>", "<Left>",  mode = "i", },
  { "<c-s>", "<Down>",  mode = "i", },
  { "<c-d>", "<Right>", mode = "i", },
})
