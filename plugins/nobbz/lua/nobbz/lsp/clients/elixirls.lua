local helpers = require("nobbz.lsp.helpers")

return {
  name = "elixirls",
  ft = "elixir",
  on_attach = { helpers.keymap, },
  cmd = { "elixir-ls", },
}
