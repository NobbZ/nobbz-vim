local helpers = require("nobbz.lsp.helpers")

return {
  name = "elixirls",
  on_attach = { helpers.keymap, },
  cmd = { "elixir-ls", },
}
