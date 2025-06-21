local helpers = require("nobbz.lsp.helpers")

require("nobbz.lazy").add_specs({
  {
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
  },
})

local function on_attach(client, buffer)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format({
        async = false,
        bufnr = buffer,
      })
    end,
  })
end

local settings = {
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
}

return {
  name = "rust_analyzer",
  on_attach = { helpers.default, on_attach, },
  settings = settings,
}
