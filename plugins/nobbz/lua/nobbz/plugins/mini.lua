require("nobbz.lazy").add_specs({ {
  "mini",
  event = "DeferredUIEnter",
  after = function()
    require("mini.pairs").setup({})
  end,
}, })
