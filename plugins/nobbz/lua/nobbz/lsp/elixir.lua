local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").nextls.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
  cmd = { "nextls", "--stdio" },
})
