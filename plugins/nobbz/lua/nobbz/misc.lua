vim.o.mouse = "a"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.ai = true
vim.o.colorcolumn = "80,100,120"

-- Set up indent markers
require("ibl").setup({
  indent = { char = "┊" },
  scope = { enabled = true },
})
