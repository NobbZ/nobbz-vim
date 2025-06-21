local helpers = require("nobbz.lsp.helpers")

return {
  name = "nushell",
  on_attach = { helpers.default, },
  filetypes = { "nu", },
  cmd = { "nu", "--lsp", },
}
