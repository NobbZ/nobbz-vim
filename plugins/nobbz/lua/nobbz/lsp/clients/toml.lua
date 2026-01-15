local helpers = require("nobbz.lsp.helpers")

return {
  name = "taplo",
  ft = "toml",
  on_attach = { helpers.default, },
  settings = {
    taplo = {
      diagnostics = { enabled = true, },
      completion = { enabled = true, },
      schema = {
        enabled = true,
        associations = {},
      },
    },
  },
}
