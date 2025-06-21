local helpers = require("nobbz.lsp.helpers")

return {
  name = "clangd",
  on_attach = { helpers.keymap, },
  cmd = { "clangd", "--background-index", },
}
