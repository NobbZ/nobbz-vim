local helpers = require("nobbz.lsp.helpers")

require("lspconfig").html.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
