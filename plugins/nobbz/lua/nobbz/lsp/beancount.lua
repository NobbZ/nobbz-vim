local helpers = require("nobbz.lsp.helpers")

-- find the root dir of the project by finding a .git folder
local git_dirs = vim.fs.find({ ".git", }, { upward = true, })
local root_dir = nil
if git_dirs[1] then
  root_dir = vim.fs.dirname(git_dirs[1])
end

-- the main journal always is "main.beancount" at the repo root
local journal_file = nil
if root_dir ~= nil then
  journal_file = vim.fs.joinpath(root_dir, "main.beancount")
end

return {
  name = "beancount",
  activate = function()
    return root_dir ~= nil and journal_file ~= nil and vim.uv.fs_stat(journal_file) ~= nil
  end,
  on_attach = { helpers.keymap, },
  init_options = { journal_file = journal_file, },
  root_dir = root_dir,
}
