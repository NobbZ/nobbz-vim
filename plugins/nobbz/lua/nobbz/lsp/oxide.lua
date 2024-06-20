local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
}

require("lspconfig").markdown_oxide.setup({
  on_attach = require("nobbz.lsp.attach"),
  capabilities = capabilities,
})

