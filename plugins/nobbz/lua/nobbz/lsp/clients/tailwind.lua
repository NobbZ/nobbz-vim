local helpers = require("nobbz.lsp.helpers")

return {
  name = "tailwindcss",
  on_attach = { helpers.keymap, },
  cmd = { "tailwindcss-language-server", "--stdio", },
}
