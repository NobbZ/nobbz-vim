local capabilites = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").digestif.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilites = capabilites,
})
