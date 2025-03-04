local helpers = require("nobbz.lsp.helpers")

require("lspconfig").ts_ls.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})
