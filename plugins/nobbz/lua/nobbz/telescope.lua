local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local wk = require("which-key")

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
    find_files = { mappings = mappings_for_modes, },
    live_grep = { mappings = mappings_for_modes, },
    buffers = { mappings = mappings_for_modes, },
  },
})

wk.add({
  { "<leader>f",  group = "find", },
  { "<leader>ff", builtin.find_files, desc = "find file by name", },
  { "<leader>fg", builtin.live_grep,  desc = "find file by content (rg)", },
  { "<leader>fb", builtin.buffers,    desc = "find buffer by name", },
  { "<leader>fh", builtin.help_tags,  desc = "open help", },
  { "<leader>fx", builtin.commands,   desc = "run command (M-x)", },
})
