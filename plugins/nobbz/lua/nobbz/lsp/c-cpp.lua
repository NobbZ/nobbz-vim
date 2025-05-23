local helpers = require("nobbz.lsp.helpers")

require("lspconfig").clangd.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
  cmd = { "clangd", "--background-index", },
})

require("nobbz.health").register_lsp("clangd")
