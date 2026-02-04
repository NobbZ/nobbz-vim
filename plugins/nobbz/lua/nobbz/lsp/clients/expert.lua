local helpers = require("nobbz.lsp.helpers")

return {
  name = "expert",
  ft = { "elixir", "eelixir", "heex", "surface", },
  on_attach = { helpers.keymap, },
}
