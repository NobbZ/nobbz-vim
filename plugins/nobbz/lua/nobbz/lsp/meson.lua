local helpers = require("nobbz.lsp.helpers")

return {
  name = "mesonlsp",
  on_attach = { helpers.keymap, },
  root_dir = require("lspconfig.util").root_pattern(".git"),
}
