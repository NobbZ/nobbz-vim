local augment_workspace = vim.env.AUGMENT_WORKSPACE

require("nobbz.lazy").add_specs({ {
  "augment.vim",
  enabled = augment_workspace,
  before = function()
    vim.g.augment_workspace_folders = { augment_workspace, }
  end,
  cmd = "Augment",
}, })
