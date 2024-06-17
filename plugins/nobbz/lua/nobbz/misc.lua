vim.o.mouse = "a"                -- allow mouse everywhere
vim.o.tabstop = 2                -- \
vim.o.softtabstop = 2            -- |
vim.o.shiftwidth = 2             -- > Set tab behaviour
vim.o.expandtab = true           -- /
vim.o.autoindent = false         -- Auto indent
vim.o.colorcolumn = "80,100,120" -- set column markers
vim.o.signcolumn = "yes"         -- always show signcolumn
vim.o.number = true              -- always show line numbers
vim.o.cursorline = true          -- slightly color the line the cursor is on
vim.o.cursorcolumn = true        -- slightly color the column the cursor is on

vim.g.mapleader = " "            -- set `<leader>` to the space key

-- Set up indent markers
require("ibl").setup({
  indent = { char = "┊" },
  scope = { enabled = true },
})
