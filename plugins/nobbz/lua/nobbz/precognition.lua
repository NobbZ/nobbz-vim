local precognition = require("precognition")

precognition.setup({
  startVisible = true,
})

WK.add({
  { "<leader>p",  group = "precognition", },
  { "<leader>pp", precognition.peek,      desc = "peek", },
  { "<leader>pt", precognition.toggle,    desc = "toggle", },
})
