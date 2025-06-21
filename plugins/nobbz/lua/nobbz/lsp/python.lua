local helpers = require("nobbz.lsp.helpers")

return {
  name = "basedpyright",
  on_attach = { helpers.keymap, },
  settings = {
    basedpyright = {
      analysis = {
        diagnosticsMode = "workspace",
        inlayHints = {
          genericTypes = true,
        },
      },
    },
  },
}
