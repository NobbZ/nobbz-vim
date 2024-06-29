local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").nil_ls.setup({
  on_attach = require("nobbz.lsp.keymap"),
  capabilities = capabilities,
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
