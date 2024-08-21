local wk = require("which-key")

vim.o.timeout = true
vim.o.timeoutlen = 300

wk.setup({})

wk.add({
  { "w",     "<Up>",    mode = { "v", "n", }, },
  { "a",     "<Left>",  mode = { "v", "n", }, },
  { "s",     "<Down>",  mode = { "v", "n", }, },
  { "d",     "<Right>", mode = { "v", "n", }, },
  { "<c-w>", "<Up>",    mode = "i", },
  { "<c-a>", "<Left>",  mode = "i", },
  { "<c-s>", "<Down>",  mode = "i", },
  { "<c-d>", "<Right>", mode = "i", },
})
