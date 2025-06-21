local capabilities = LSP_CAPAS
local helpers = require("nobbz.lsp.helpers")

capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
}

return {
  name = "markdown_oxide",
  on_attach = { helpers.default, },
  capabilities = capabilities,
}
