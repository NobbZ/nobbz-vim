local helpers = require("nobbz.lsp.helpers")

require("lspconfig").digestif.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})

require("nobbz.health").register_lsp("digestif")
