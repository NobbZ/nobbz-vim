local lazy = require("nobbz.lazy")

WK = require("which-key")
-- TODO: make this available via lsp-helpers
LSP_CAPAS = require("blink.cmp").get_lsp_capabilities({
  textDocument = {
    foldingRange = {
      dynamicRegistration = true,
      lineFoldingOnly = true,
    },
  },
})

---A small helper function to lazily require.
---
---It is especially helpful together with
---@param modname string
---@return function
local function rf(modname)
  return function()
    require(modname)
  end
end

local this_module = ...

---A small helper function to require a submodule "relatively"
---@param submodule string
---@return unknown
local function rs(submodule)
  return require(this_module .. "." .. submodule)
end

--- Load individual plugin specifications by scanning the `plugins` directory.
local function discover_plugins()
  ---@type string[]
  local plugins = {}

  -- Get the directory of the current file
  local current_file = debug.getinfo(1, "S").source:sub(2) -- remove `@` prefix
  local base_dir = vim.fs.dirname(current_file)

  -- plugin folder
  local plugins_dir = vim.fs.joinpath(base_dir, "plugins")

  local candidates = vim.fs.dir(plugins_dir)
  for name, type in candidates do
    if type == "file" and name:match("%.lua$") then
      local module_name = name:gsub("%.lua$", "")
      table.insert(plugins, "nobbz.plugins." .. module_name)
    end
  end

  -- sorting *should* not matter, though if it becomes an issue, deterministically
  -- ordered modules will be easier to debug than non-deterministically ordered.
  table.sort(plugins)

  return plugins
end

for _, module in ipairs(discover_plugins()) do
  require(module)
end

rs("lsp") -- LSP and related setup

if vim.g.neovide then rs("neovide") end

lazy.add_specs({
  { "startuptime", command = "StartUptime", after = rf("nobbz.startuptime"), },
})

lazy.finish()

require("nobbz.health").done()
