local helpers = require("nobbz.lsp.helpers")

require("lspconfig").gleam.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
