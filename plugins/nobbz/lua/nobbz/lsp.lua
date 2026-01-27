local null_ls = require("null-ls")
local helpers = require("nobbz.lsp.helpers")
local register_lsp = require("nobbz.health").register_lsp
local register_treesitter = require("nobbz.plugins.treesitter").register

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local ls_sources = {
  -- formatting.stylua,
  formatting.alejandra,
  --code_actions.statix,
  --diagnostics.deadnix,
}

local blink_capas = require("blink.cmp").get_lsp_capabilities({
  textDocument = {
    foldingRange = {
      dynamicRegistration = true,
      lineFoldingOnly = true,
    },
  },
})

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

-- Load individual languages configuration by scanning clients directory
local function discover_clients()
  local clients = {}
  -- Get the directory of the current file and append "clients"
  local current_file = debug.getinfo(1, "S").source:sub(2) -- Remove the '@' prefix
  local base_dir = vim.fn.fnamemodify(current_file, ":h")
  local client_dir = vim.fs.joinpath(base_dir, "lsp", "clients")

  -- Scan the clients directory for Lua files
  local scan = vim.uv.fs_scandir(client_dir)
  if not scan then
    vim.notify("unable to scan '" .. client_dir .. "' for LSP clients")
    return clients
  end

  while true do
    local name, type = vim.uv.fs_scandir_next(scan)
    if not name then break end
    if type == "file" and name:match("%.lua$") then
      -- Convert filename to module path (remove .lua extension)
      local module_name = name:gsub("%.lua$", "")
      table.insert(clients, "nobbz.lsp.clients." .. module_name)
    end
  end

  -- sorting *should* not matter, though if it becomes an issue, deterministically
  -- ordered modules will be easier to debug than non-deterministically ordered.
  table.sort(clients)

  return clients
end

local clients = discover_clients()

for _, client_module in ipairs(clients) do
  local client_config = require(client_module)

  -- Extract required fields with validation
  local name = client_config.name or error("client name is required in " .. client_module)

  -- Shortcircuit if LS should not be loaded
  if client_config.activate and not client_config.activate() then
    goto continue
  end

  local capabilities = client_config.capabilities or blink_capas
  if type(capabilities) == "function" then
    capabilities = capabilities(vim.deepcopy(blink_capas))
  end

  -- Create setup table with defaults applied
  local setup = {
    on_attach = helpers.combine(client_config.on_attach or { helpers.default, }),
    capabilities = capabilities,
    init_options = client_config.init_options,
    root_dir = client_config.root_dir,
    cmd = client_config.cmd,
    settings = client_config.settings,
    on_init = client_config.on_init,
    filetypes = client_config.filetypes,
  }

  if client_config.ft then
    if type(client_config.ft) == "table" then
      for _, ft in ipairs(client_config.ft) do
        register_treesitter(ft)
      end
    else
      register_treesitter(client_config.ft)
    end
  end

  vim.lsp.config(name, setup)
  vim.lsp.enable(name)

  register_lsp(client_config.name)

  ::continue::
end
