local helpers = require("nobbz.lsp.helpers")

return {
  name = "markdown_oxide",
  on_attach = { helpers.default, },
  capabilities = function(capabilities)
    capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }

    return capabilities
  end,
}
