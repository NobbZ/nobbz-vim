local helpers = require("nobbz.lsp.helpers")

return {
  name = "ts_ls",
  on_attach = { helpers.keymap, },
  cmd = { "typescript-language-server", "--stdio", },
}
