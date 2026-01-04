require("nobbz.lazy").add_specs({
  {
    "surround",
    after = function()
      -- We use the default configuration for now. Until I have a bit better
      -- understanding of the options.
      require("nvim-surround").setup({})
      
      -- Setup filetype-specific surrounds for raw strings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          require("nvim-surround").buffer_setup({
            surrounds = {
              ["R"] = {
                add = { 'r#"', '"#' },
                find = 'r%#".-"%#',
                delete = '^(r%#")().-("%#)()$',
              },
            },
          })
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "elixir",
        callback = function()
          require("nvim-surround").buffer_setup({
            surrounds = {
              ["R"] = {
                add = { '~S"""', '"""' },
                find = '~S""".-"""',
                delete = '^(~S""")().-("")")()$',
              },
            },
          })
        end,
      })
    end,
    keys = {
      { "ys", mode = { "n", }, },
      { "ds", mode = { "n", }, },
      { "cs", mode = { "n", }, },
      { "S",  mode = { "v", }, },
    },
  },
})
