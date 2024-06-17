local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").tailwindcss.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
})
