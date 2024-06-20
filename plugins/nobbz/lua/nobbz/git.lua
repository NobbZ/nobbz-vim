local neogit = require("neogit")
local gitsigns = require("gitsigns")

neogit.setup({})

-- register keys for neogit
require("which-key").register({
  g = { "<cmd>:Neogit<CR>", "neogit status" },
}, { prefix = "<leader>" })

gitsigns.setup()
