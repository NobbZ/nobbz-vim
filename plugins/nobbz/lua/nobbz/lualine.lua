local lualine = require("lualine")

lualine.setup({
  theme = "onedark",
  sections = {
    lualine_c = {
      "filename",
    },
  },
})
