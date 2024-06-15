local tele = require("telescope.builtin")

-- register keys for telescope.
vim.keymap.set("n", "<leader>ff", tele.find_files, { desc = "files" })
vim.keymap.set("n", "<leader>fg", tele.live_grep, { desc = "text (rg)" })
vim.keymap.set("n", "<leader>fb", tele.buffers, { desc = "buffers" })
vim.keymap.set("n", "<leader>fh", tele.help_tags, { desc = "help" })
vim.keymap.set("n", "<leader>fx", tele.commands, { desc = "commands (M-x)" })

-- make which-key preview a but nicer
require("which-key").register({
  f = { name = "find" },
}, { prefix = "<leader>" })
