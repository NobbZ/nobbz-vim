require("nobbz.lazy").add_specs({ {
  "lspsaga",
  event = "VimEnter",
  config = function()
    require("lspsaga").setup({
    })
  end,
}, })
