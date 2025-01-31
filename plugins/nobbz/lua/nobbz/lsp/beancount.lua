local helpers = require("nobbz.lsp.helpers")

require("lspconfig").beancount.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
