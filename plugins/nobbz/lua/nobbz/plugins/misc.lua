-- stylua: ignore start
vim.o.mouse = "a"                -- allow mouse everywhere
vim.o.tabstop = 2                -- \
vim.o.softtabstop = 2            -- |
vim.o.shiftwidth = 2             -- > Set tab behaviour
vim.o.expandtab = true           -- /
vim.o.autoindent = true          -- Auto indent
vim.o.smartindent = true
vim.o.colorcolumn = "80,100,120" -- set column markers
vim.o.signcolumn = "yes"         -- always show signcolumn
vim.o.number = true              -- always show line numbers
vim.o.relativenumber = false     -- vim poeple seem to love it, I don't. Explicit disable to be save against changes in the default
vim.o.cursorline = true          -- slightly color the line the cursor is on
vim.o.cursorcolumn = true        -- slightly color the column the cursor is on
vim.o.clipboard = "unnamedplus"  -- yank/delete into system clipboard
vim.o.list = true
vim.o.listchars = "tab:⇢⇥,trail:⎵,eol:↩"
vim.o.wrap = false
-- stylua: ignore end

vim.g.mapleader = " " -- set `<leader>` to the space key

-- Set up indent markers
require("ibl").setup({
  indent = { char = "┊", },
  scope = { enabled = true, },
})

---Sets linemode to the requested numbering.
---@param numbering_mode "relative"|"absolute"|"toggle" which mode shall be activated by the keypress
---@return function
local function change_linum_mode(numbering_mode)
  if numbering_mode == "toggle" then
    return function() vim.o.relativenumber = not vim.o.relativenumber end
  elseif numbering_mode == "relative" or numbering_mode == "absolute" then
    local rel = numbering_mode == "relative"
    return function() vim.o.relativenumber = rel end
  end

  error("'" .. numbering_mode .. "' is not a valid mode")
end

WK.add({
  { "<leader>#",  group = "line numbering modes", },
  { "<leader>##", change_linum_mode("toggle"),    desc = "toggle relativenumber", },
  { "<leader>#+", change_linum_mode("relative"),  desc = "enable relativenumber", },
  { "<leader>#-", change_linum_mode("absolute"),  desc = "disable relativenumber", },
})
