local M = {}

---finishes the configuration of `lz.n`.
M.finish = function()
  require("lz.n").load(require("nobbz.lazy.specs"))
end

---@param name string
M.packadd = function(name)
  vim.api.nvim_cmd({ cmd = "packadd", args = { name, }, }, {})
end

---@param name string
M.load_once = function(name)
  local state = require("lz.n.state").plugins
  require("lz.n").trigger_load(name)

  for k, v in ipairs(state) do
    if v == name then
      table.remove(state, k)
      break
    end
  end
end

---@param specs lz.n.Spec[]
M.add_specs = function(specs)
  vim.list_extend(require("nobbz.lazy.specs"), specs)
end

return M
