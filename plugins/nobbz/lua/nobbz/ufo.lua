vim.o.foldcolumn = "auto:2"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.fillchars = "foldopen:╭,foldclose:·,foldsep:│"
-- prefered "tail": ╰

require("nobbz.lazy").add_specs({ {
  "nvim-ufo",
  event = "DeferredUIEnter",
  after = function()
    local ufo = require("ufo")
    ufo.setup({
      provider_selector = function()
        return { "lsp", "indent", }
      end,
    })

    WK.add({
      { "zR", ufo.openAllFolds,  desc = "open all folds", },
      { "zM", ufo.closeAllFolds, desc = "close all folds", },
    })
  end,
  keys = {
    { "zR", desc = "open all folds", },
    { "zM", desc = "close all folds", },
  },
}, })
