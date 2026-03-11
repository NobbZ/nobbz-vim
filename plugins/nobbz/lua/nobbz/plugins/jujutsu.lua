require("nobbz.lazy").add_specs({ {
  "jj-nvim",
  after = function()
    require("jj").setup({})
  end,
  cmd = { "J", "JBrowse", "Jdiff", "Jvdiff", "Jhdiff", },
}, })
