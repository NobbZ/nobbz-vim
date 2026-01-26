require("nobbz.lazy").add_specs({ {
  "indent-blankline",
  event = "DeferredUIEnter",
  after = function()
    require("ibl").setup({
      indent = { char = "┊", },
      scope = { enabled = true, },
    })
  end,
}, })
