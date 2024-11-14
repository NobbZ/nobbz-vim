local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").elixirls.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
  cmd = { "elixir-ls", },
})
