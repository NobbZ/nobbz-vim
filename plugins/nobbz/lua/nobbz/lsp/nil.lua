local helpers = require("nobbz.lsp.helpers")

return {
  name = "nil_ls",
  on_attach = { helpers.keymap, },
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
}
