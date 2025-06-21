local helpers = require("nobbz.lsp.helpers")

return {
  name = "gleam",
  on_attach = { helpers.keymap, },
}
