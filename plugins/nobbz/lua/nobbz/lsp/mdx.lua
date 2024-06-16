local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  }
})

require("lspconfig").mdx_analyzer.setup({
  capabilities = capabilities,
})
