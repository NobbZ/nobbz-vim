local helpers = require("nobbz.lsp.helpers")

return {
  name = "typst_lsp",
  on_attach = { helpers.default, },
}
