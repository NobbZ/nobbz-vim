local helpers = require("nobbz.lsp.helpers")

require("nobbz.treesitter").register("elixir")

return {
  name = "elixirls",
  on_attach = { helpers.keymap, },
  cmd = { "elixir-ls", },
}
