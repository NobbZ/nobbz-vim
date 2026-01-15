local helpers = require("nobbz.lsp.helpers")

return {
  name = "yamlls",
  ft = "yaml",
  on_attach = { helpers.default, },
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
      validate = true,
      hover = true,
      completion = true,
    },
  },
}
