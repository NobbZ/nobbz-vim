local capabilities = require("cmp_nvim_lsp").default_capabilities()
local helpers = require("nobbz.lsp.helpers")

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

require("lspconfig").mdx_analyzer.setup({
  on_attach = helpers.keymap,
  capabilities = capabilities,
})
