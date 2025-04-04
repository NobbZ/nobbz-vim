require("nobbz.lazy").add_specs({ {
  "lspsaga",
  event = "DeferredUIEnter",
  after = function()
    vim.print("loading lspsaga")
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = true,
      },
      outline = {
        close_after_jump = true,
      },
    })
  end,
}, })

WK.add({
  { "<leader>lp",    group = "peek", },
  { "<leader>lpd",   "<cmd>Lspsaga peek_definition<cr>",      desc = "peek definition", },
  { "<leader>lpt",   "<cmd>Lspsaga peek_type_definition<cr>", desc = "peek type definition", },
  { "<leader>l<lt>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "jump to previous diagnostic", },
  { "<leader>l>",    "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "jump to next diagnostic", },
  { "<leader>lf",    "<cmd>Lspsaga finder<cr>",               desc = "find references and implementations", },
})
