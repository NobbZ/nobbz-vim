local helpers = require("nobbz.lsp.helpers")

require("lspconfig").elixirls.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
  cmd = { "elixir-ls", },
})
