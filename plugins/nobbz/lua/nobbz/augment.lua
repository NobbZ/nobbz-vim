local augment_workspace = vim.env.AUGMENT_WORKSPACE
local augment_node = vim.env.AUGMENT_NODE

---return a function to accept the augment completion
---@param fallback string? the fallback if there is no completion available
---@return function
local function accept_completion(fallback)
  if fallback then
    return function() vim.fn["augment#Accept"](fallback) end
  else
    return function() vim.fn["augment#Accept"]() end
  end
end

require("nobbz.lazy").add_specs({ {
  "augment",
  enabled = function()
    return augment_workspace ~= nil and augment_node ~= nil
  end,
  before = function(plugin)
    vim.g.augment_workspace_folders = { augment_workspace, }
    vim.g.augment_node_command = augment_node

    vim.g.augment_disable_tab_mapping = true
  end,
  cmd = "Augment",
  event = "DeferredUIEnter",
}, })

WK.add({
  { "<leader>a",  group = "augment", },
  { "<leader>ac", "<cmd>Augment chat<cr>",        desc = "Send chat message", },
  { "<leader>an", "<cmd>Augment chat-new<cr>",    desc = "Start new conversation", },
  { "<leader>at", "<cmd>Augment chat-toggle<cr>", desc = "Toggle chat panel", },
  { "<leader>as", "<cmd>Augment status<cr>",      desc = "Check Augment status", },
  { "<C-y>",      accept_completion(),            desc = "Accept Augment completion",              mode = { "i", "s", }, },
  { "<C-cr>",     accept_completion("\n"),        desc = "Accept Augment completion (or newline)", mode = { "i", "s", }, },

})
