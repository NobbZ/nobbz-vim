local capabilities = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("nobbz.lsp.helpers")

require("lspconfig").tailwindcss.setup({
  on_attach = helpers.keymap,
  capabilities = capabilities,
})
