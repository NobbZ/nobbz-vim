require("nobbz.lazy").add_specs({ {
  "catppuccin",
  event = "DeferredUIEnter",
  after = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        blink_cmp = true,
        noice = true,
        cmp = false,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}, })
