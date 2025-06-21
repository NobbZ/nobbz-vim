local null_ls = require("null-ls")
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
local clients = {
  "nobbz.lsp.astro",
  "nobbz.lsp.beancount",
  "nobbz.lsp.c-cpp",
  "nobbz.lsp.digestif",
  "nobbz.lsp.elixir",
  "nobbz.lsp.gleam",
  "nobbz.lsp.html",
  "nobbz.lsp.lua",
  "nobbz.lsp.mdx",
  "nobbz.lsp.meson",
  "nobbz.lsp.nil",
  "nobbz.lsp.nushell",
  "nobbz.lsp.oxide",
  "nobbz.lsp.python",
  "nobbz.lsp.rust",
  "nobbz.lsp.tailwind",
  "nobbz.lsp.typescript",
  "nobbz.lsp.zig",
}

for _, client_module in ipairs(clients) do
  local client_config = require(client_module)

  -- Extract required fields with validation
  local name = client_config.name or error("client name is required in " .. client_module)

  -- Shortcircuit if LS should not be loaded
  if client_config.activate and not client_config.activate() then
    goto continue
  end

  -- Create setup table with defaults applied
  local setup = {
    on_attach = helpers.combine(client_config.on_attach or { helpers.default, }),
    capabilities = client_config.capabilities or LSP_CAPAS,
    init_options = client_config.init_options,
    root_dir = client_config.root_dir,
    cmd = client_config.cmd,
    settings = client_config.settings,
    on_init = client_config.on_init,
    filetypes = client_config.filetypes,
  }

  vim.lsp.config(name, setup)
  vim.lsp.enable(name)

  register_lsp(client_config.name)

  ::continue::
end
