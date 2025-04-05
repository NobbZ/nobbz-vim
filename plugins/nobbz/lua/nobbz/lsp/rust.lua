local lspconfig = require("lspconfig")
local helpers = require("nobbz.lsp.helpers")

lspconfig.rust_analyzer.setup({
  on_attach = helpers.combine({
    helpers.default,
    function(client, buffer)
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
  }),
  capabilities = LSP_CAPAS,
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

require("nobbz.lazy").add_specs({ {
  "crates",
  after = function()
    require("crates").setup({
      lsp = {
        enabled = true,
        on_attach = helpers.default,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
  ft = { "toml", },
}, })
