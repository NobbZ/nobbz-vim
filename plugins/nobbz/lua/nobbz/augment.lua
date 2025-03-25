local augment_workspace = vim.env.AUGMENT_WORKSPACE
local augment_node = vim.env.AUGMENT_NODE

require("nobbz.lazy").add_specs({ {
  "augment",
  enabled = function()
    return augment_workspace ~= nil and augment_node ~= nil
  end,
  before = function(plugin)
    vim.g.augment_workspace_folders = { augment_workspace, }
    vim.g.augment_node_command = augment_node
  end,
  cmd = "Augment",
}, })

WK.add({
  { "<leader>a",  group = "augment", },
  { "<leader>ac", "<cmd>Augment chat<cr>",        desc = "Send chat message", },
  { "<leader>an", "<cmd>Augment chat-new<cr>",    desc = "Start new conversation", },
  { "<leader>at", "<cmd>Augment chat-toggle<cr>", desc = "Toggle chat panel", },
  { "<leader>as", "<cmd>Augment status<cr>",      desc = "Check Augment status", },
})
