local helpers = require("nobbz.lsp.helpers")

require("lspconfig").tailwindcss.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
