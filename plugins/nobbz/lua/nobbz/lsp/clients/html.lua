local helpers = require("nobbz.lsp.helpers")

return {
  name = "html",
  on_attach = { helpers.keymap, },
}
