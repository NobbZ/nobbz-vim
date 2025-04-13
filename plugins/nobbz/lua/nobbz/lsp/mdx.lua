local helpers = require("nobbz.lsp.helpers")

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

require("lspconfig").mdx_analyzer.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
})

require("nobbz.health").register_lsp("mdx_analyzer")
