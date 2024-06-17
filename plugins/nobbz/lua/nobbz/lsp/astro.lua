local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").astro.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
})
