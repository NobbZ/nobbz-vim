local helpers = require("nobbz.lsp.helpers")

require("lspconfig").astro.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})

require("nobbz.health").register_lsp("astro")
