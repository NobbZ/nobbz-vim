local helpers = require("nobbz.lsp.helpers")

require("lspconfig").tsserver.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
