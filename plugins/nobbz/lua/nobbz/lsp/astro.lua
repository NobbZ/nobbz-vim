local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").astro.setup({
  capabilities = capabilities,
})
