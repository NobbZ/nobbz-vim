local helpers = require("nobbz.lsp.helpers")

require("lspconfig").basedpyright.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
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
})
