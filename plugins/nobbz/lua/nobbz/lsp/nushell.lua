local helpers = require("nobbz.lsp.helpers")

require("lspconfig").nushell.setup({
  on_attach = helpers.default,
  capabilities = LSP_CAPAS,
  filetypes = { "nu", },
  cmd = { "nu", "--lsp", },
})
