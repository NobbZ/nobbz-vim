local gitsigns = require("gitsigns")
local neogit = require("neogit")
local wk = require("which-key")

neogit.setup({})

-- register keys for neogit
wk.add({
  { "<leader>g", "<cmd>:Neogit<cr>", desc = "Neogit status", },
})

gitsigns.setup()
