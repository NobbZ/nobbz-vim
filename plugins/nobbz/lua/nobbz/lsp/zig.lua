local helpers = require("nobbz.lsp.helpers")

return {
  name = "zls",
  on_attach = { helpers.default, },
}
