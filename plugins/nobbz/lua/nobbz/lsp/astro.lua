local helpers = require("nobbz.lsp.helpers")

return {
  name = "astro",
  on_attach = { helpers.keymap, },
}
