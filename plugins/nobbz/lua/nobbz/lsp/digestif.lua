local helpers = require("nobbz.lsp.helpers")

return {
  name = "digestif",
  on_attach = { helpers.keymap, },
}
