local showkeys = require("showkeys")

showkeys.setup({
  timeout = 5,
  maxkeys = 5,
})

WK.add {
  { "<leader>s",   group = "ScreenCasting Tools", },
  { "<leader>sk",  group = "Showkeys", },
  { "<leader>skk", showkeys.toggle,               desc = "toggle", },
  { "<leader>ske", showkeys.open,                 desc = "enable", },
  { "<leader>skd", showkeys.close,                desc = "disable", },
}
