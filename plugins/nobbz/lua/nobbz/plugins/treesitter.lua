---@diagnostic disable: missing-fields
require("nvim-treesitter").setup({
  ensure_installed = {},
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, },
  incremental_selection = {
    enable = true,
  },
})

local M = {}

--- Register the given `filetype` for treesitter.
---
--- @param filetype string
function M.register(filetype)
  local group = vim.api.nvim_create_augroup("NobbZTreesitter_" .. filetype, { clear = true, })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = filetype,
    callback = function() vim.treesitter.start() end,
  })
end

return M
