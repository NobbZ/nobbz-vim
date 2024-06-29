local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")

local mappings = {
  ["<C-2>"] = actions.select_horizontal,
  ["<C-5>"] = actions.select_vertical,
  ['<C-">'] = actions.select_horizontal,
  ["<C-%>"] = actions.select_vertical,
  ["<C-v>"] = false,
  ["<C-x>"] = false,
}

local mappings_for_modes = {
  n = mappings,
  i = mappings,
}

--  set internal mappings for telescope
telescope.setup({
  pickers = {
    find_files = { mappings = mappings_for_modes },
    live_grep = { mappings = mappings_for_modes },
    buffers = { mappings = mappings_for_modes },
  },
})

-- register keys for telescope.
-- TODO: move this to which-key
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "text (rg)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help" })
vim.keymap.set("n", "<leader>fx", builtin.commands, { desc = "commands (M-x)" })

-- make which-key preview a but nicer
require("which-key").register({
  f = { name = "find" },
}, { prefix = "<leader>" })
