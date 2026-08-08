require("nobbz.lazy").add_specs({ {
  "love2d",
  event = "DeferredUIEnter",
  after = function()
    require("love2d").setup({})
  end,
}, })
