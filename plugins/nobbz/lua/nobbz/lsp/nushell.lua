local capabilities = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("nobbz.lsp.helpers")

require("lspconfig").nushell.setup({
  on_attach = helpers.default,
  capabilities = capabilities,
  filetypes = { "nu", },
  cmd = { "nu", "--lsp", },
})
