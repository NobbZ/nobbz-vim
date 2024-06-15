local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").nextls.setup({
  capabilities = capabilities,
  cmd = { "nextls", "--stdio" },
})
