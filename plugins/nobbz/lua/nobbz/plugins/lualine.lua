local lualine = require("lualine")

lualine.setup({
  theme = "catppuccin",
  sections = {
    lualine_c = {
      "filename",
    },
  },
})
