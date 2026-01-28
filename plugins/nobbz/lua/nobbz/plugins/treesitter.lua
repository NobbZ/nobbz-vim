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

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NobbZTreesitter_allLangs", { clear = true, }),
  pattern = require("nvim-treesitter").get_available(),
  callback = function()
    vim.treesitter.start()
  end,
})
