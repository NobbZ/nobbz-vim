local helpers = require("nobbz.lsp.helpers")

return {
  name = "jsonls",
  ft = "json",
  on_attach = { helpers.default, },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true, },
    },
  },
}
