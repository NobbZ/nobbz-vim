local gitsigns = require("gitsigns")
local neogit = require("neogit")

neogit.setup({})

-- register keys for neogit
WK.add({
  { "<leader>g", "<cmd>:Neogit<cr>", desc = "Neogit status", },
})

gitsigns.setup()
