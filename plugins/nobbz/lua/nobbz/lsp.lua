local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local helpers = require("nobbz.lsp.helpers")
local register_lsp = require("nobbz.health").register_lsp

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
require("nobbz.lsp.nushell")
require("nobbz.lsp.oxide")
require("nobbz.lsp.python")
require("nobbz.lsp.rust")
require("nobbz.lsp.tailwind")
require("nobbz.lsp.typescript")
require("nobbz.lsp.zig")

local clients = {
  require("nobbz.lsp.astro"),
  require("nobbz.lsp.beancount"),
  require("nobbz.lsp.c-cpp"),
  require("nobbz.lsp.digestif"),
  require("nobbz.lsp.elixir"),
  require("nobbz.lsp.gleam"),
  require("nobbz.lsp.html"),
  require("nobbz.lsp.lua"),
  require("nobbz.lsp.mdx"),
  require("nobbz.lsp.meson"),
  require("nobbz.lsp.nil"),
}

for _, client_config in ipairs(clients) do
  local name = client_config.name or error("client name is required")
  local activate = client_config.activate or function() return true end
  local capabilities = client_config.capabilities or LSP_CAPAS
  local on_attach = client_config.on_attach or { helpers.default, }
  local init_options = client_config.init_options
  local root_dir = client_config.root_dir
  local cmd = client_config.cmd
  local settings = client_config.settings
  local on_init = client_config.on_init

  local setup = {
    on_attach = helpers.combine(on_attach),
    capabilities = capabilities,
    init_options = init_options,
    root_dir = root_dir,
    cmd = cmd,
    settings = settings,
    on_init = on_init,
  }

  if activate() then
    lspconfig[name].setup(setup)

    register_lsp(client_config.name)
  end
end
