local helpers = require("nobbz.lsp.helpers")

return {
  name = "tailwindcss",
  on_attach = { helpers.keymap, },
}
