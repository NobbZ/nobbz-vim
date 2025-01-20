local helpers = require("nobbz.lsp.helpers")

require("lspconfig").digestif.setup({
  on_attach = helpers.keymap,
  capabilites = LSP_CAPAS,
})
