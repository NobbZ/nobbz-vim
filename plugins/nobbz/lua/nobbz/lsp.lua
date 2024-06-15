local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local ls_sources = {
  formatting.stylua,
  formatting.rustfmt,
  --formatting.alejandra,
  --code_actions.statix,
  --diagnostics.deadnix,
}

-- Enable null-ls
require("null-ls").setup({
  diagnostics_format = "[#{m}] #{s} (#{c})",
  debounce = 250,
  default_timeout = 5000,
  sources = ls_sources,
  on_attach = default_on_attach,
})

-- Enable lspconfig
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Load individual languages configuration
require("nobbz.lsp.astro")
require("nobbz.lsp.elixir")
require("nobbz.lsp.lua")
require("nobbz.lsp.nil")
require("nobbz.lsp.tailwind")
require("nobbz.lsp.typescript")
