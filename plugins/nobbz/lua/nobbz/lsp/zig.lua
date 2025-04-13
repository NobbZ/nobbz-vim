local helpers = require("nobbz.lsp.helpers")

require("lspconfig").zls.setup({
  on_attach = helpers.default,
  capabilities = LSP_CAPAS,
})

require("nobbz.health").register_lsp("zls")
