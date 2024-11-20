local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
  on_attach = function(client, buffer)
    require("nobbz.lsp.attach")(client --[[@as vim.lsp.Client]], buffer)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          bufnr = buffer,
        })
      end,
    })
  end,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        typeHints = { enable = true, },
        chainingHints = { enable = true, },
        bindingModeHints = { enable = true, },
        closureReturnTypeHints = { enable = "always", },
        lifetimeElisionHints = { enable = "always", },
        maxLength = 5,
        enable = true,
      },
      lens = { enable = true, },
      checkOnSave = {
        command = "clippy",
        allFeatures = true,
      },
    },
  },
})
