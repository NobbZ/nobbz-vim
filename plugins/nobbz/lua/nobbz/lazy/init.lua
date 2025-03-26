-- Huge parts of the implementation of this module has been borrowd from ViperML.
-- https://github.com/viperML/dotfiles/tree/8fd5755078e65ce905d53fb4d72f562a4487156e/modules/wrapper-manager/neovim/viper-init-plugin/lua/viper/lazy

local M = {}
local _finished = false

--- Completes the configuration by loading all specifications.
--- This *must* be called after all specs have been added.
---
--- After this has been called, there is no way to effectively add more specs.
M.finish = function()
  _finished = true
  require("lz.n").load(require("nobbz.lazy.specs"))
end

---@param name string
M.packadd = function(name)
  vim.api.nvim_cmd({ cmd = "packadd", args = { name, }, }, {})
end

---@param name string
M.load_once = function(name)
  if not name or type(name) ~= "string" then
    vim.notify("Invalid plugin name provided", vim.log.levels.ERROR)
    return
  end

  local state = require("lz.n.state").plugins
  require("lz.n").trigger_load(name)

  for k, v in ipairs(state) do
    if v == name then
      table.remove(state, k)
      return
    end
  end

  -- Only reached if `name` was not in `state`:
  vim.notify("Plugin " .. name .. " not found in state", vim.log.levels.WARN)
end

---@param specs lz.n.Spec[]
M.add_specs = function(specs)
  if _finished then
    vim.notify("Cannot add specs after nobbz.lazy.finish() has been called", vim.log.levels.WARN)
    return
  end

  vim.list_extend(require("nobbz.lazy.specs"), specs)
end

return M
