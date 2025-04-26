local helpers = require("nobbz.lsp.helpers")

require("lspconfig").mesonlsp.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
  root_dir = require("lspconfig.util").root_pattern(".git"),
})

require("nobbz.health").register_lsp("mesonlsp")
