local capabilities = LSP_CAPAS
local helpers = require("nobbz.lsp.helpers")

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
}

require("lspconfig").markdown_oxide.setup({
  on_attach = helpers.default,
  capabilities = capabilities,
})

require("nobbz.health").register_lsp("markdown_oxide")
