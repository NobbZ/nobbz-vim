local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

require("lspconfig").mdx_analyzer.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
})
