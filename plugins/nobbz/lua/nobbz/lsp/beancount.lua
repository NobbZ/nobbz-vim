local helpers = require("nobbz.lsp.helpers")

-- find the root dir of the project by finding a .git folder
local root_dir = vim.fs.dirname(vim.fs.find({ ".git", }, { upward = true, })[1])
-- the main journal always is "main.beancount" at the repo root
local journal_file = nil
if root_dir ~= nil then
  journal_file = vim.fs.joinpath(root_dir, "main.beancount")
end

if root_dir ~= nil and journal_file ~= nil then
  require("lspconfig").beancount.setup({
    on_attach = helpers.keymap,
    capabilities = LSP_CAPAS,
    root_dir = root_dir,
    init_options = { journal_file = journal_file, },
  })

  require("nobbz.health").register_lsp("beancount")
end
