local catppuccin = require("catppuccin")

catppuccin.setup({
  flavour = "mocha",
  integrations = {
    blink_cmp = true,
    noice = true,
    cmp = false,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
