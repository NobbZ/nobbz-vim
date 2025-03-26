require("nobbz.lazy").add_specs({
  {
    "surround",
    after = function()
      -- We use the default configuration for now. Until I have a bit better
      -- understanding of the options.
      require("nvim-surround").setup({})
    end,
    keys = {
      { "ys", mode = { "n", }, },
      { "ds", mode = { "n", }, },
      { "cs", mode = { "n", }, },
      { "S",  mode = { "v", }, },
    },
  },
})
