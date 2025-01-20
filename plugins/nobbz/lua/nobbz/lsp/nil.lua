local helpers = require("nobbz.lsp.helpers")

require("lspconfig").nil_ls.setup({
  on_attach = helpers.keymap,
  capabilities = LSP_CAPAS,
  cmd = { "nil", },
  settings = {
    ["nil"] = {
      nix = {
        binary = "nix",
        maxMemoryMB = nil,
        flake = {
          autoEvalInputs = false,
          autoArchive = false,
          nixpkgsInputName = nil,
        },
      },
      formatting = {
        command = { "alejandra", "--", },
      },
    },
  },
})
