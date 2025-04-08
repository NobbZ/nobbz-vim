local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local ls_sources = {
  -- formatting.stylua,
  formatting.alejandra,
  --code_actions.statix,
  --diagnostics.deadnix,
}

-- Enable null-ls
null_ls.setup({
  diagnostics_format = "[#{m}] #{s} (#{c})",
  debounce = 250,
  default_timeout = 5000,
  sources = ls_sources,
  on_attach = require("nobbz.lsp.helpers").default,
})

-- Enable lspconfig
-- local lspconfig = require("lspconfig")
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("blink.cmp").get_lsp_capabilities()

-- Load individual languages configuration
require("nobbz.lsp.astro")
require("nobbz.lsp.beancount")
require("nobbz.lsp.digestif")
require("nobbz.lsp.elixir")
require("nobbz.lsp.gleam")
require("nobbz.lsp.html")
require("nobbz.lsp.lua")
require("nobbz.lsp.mdx")
require("nobbz.lsp.nil")
require("nobbz.lsp.nushell")
require("nobbz.lsp.oxide")
require("nobbz.lsp.python")
require("nobbz.lsp.rust")
require("nobbz.lsp.tailwind")
require("nobbz.lsp.typescript")
require("nobbz.lsp.zig")
