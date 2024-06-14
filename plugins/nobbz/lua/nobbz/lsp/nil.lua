local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").nil_ls.setup({
  capabilities = capabilities,
  -- on_attach = default_on_attach,
  cmd = { "nil" },
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
        command = { "nix", "fmt" },
      },
    },
  },
})
