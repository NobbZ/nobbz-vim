local gitsigns = require("gitsigns")
local neogit = require("neogit")

neogit.setup({})

-- register keys for neogit
require("which-key").register({
  g = { "<cmd>:Neogit<CR>", "neogit status", },
}, { prefix = "<leader>", })

gitsigns.setup()
