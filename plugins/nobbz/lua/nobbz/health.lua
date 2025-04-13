local M = {}

local programs = {}
local done = false

---@param program string the program to check
---@return boolean whether the program is in the `PATH`
local function in_path(program)
  return vim.fn.executable(program) == 1
end

local function check_programs()
  local binaries = {}

  vim.health.start("Programs in `PATH`:")
  for program, required in pairs(programs) do
    if in_path(program) then
      table.insert(binaries, { program, vim.health.ok, "is installed", 1, })
    elseif required then
      table.insert(binaries, { program, vim.health.error, "is not installed", 3, })
    else
      table.insert(binaries, { program, vim.health.warn, "is not installed", 2, })
    end
  end

  table.sort(binaries, function(a, b)
    -- Sort by program name, if same criticality
    if a[4] == b[4] then return a[1] < b[1] end

    -- Sort by criticality otherwise
    return a[4] < b[4]
  end)

  for _, info in ipairs(binaries) do
    info[2]("`" .. info[1] .. "` " .. info[3])
  end
end

---Registers a program for the healthcheck, the program will be searched in the
---`PATH`.
---
---If a program is registered for a second time, the `required` will be overwritten.
---
---@param program string the name of the program
---@param required boolean whether the program is required (missing programs
---  will issue an error when required, a warning otherwise)
M.register_program = function(program, required)
  programs[program] = required
end

---@param program string the program to unregister, it will not be checked by
---  the healthcheck anymore
M.unregister_program = function(program)
  programs[program] = nil
end

M.register_lsp = function(lsp)
  local config = require("lspconfig")[lsp]
  local program = config.cmd[1]
  local pattern = config.filetypes[1]

  M.register_program(program, false)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function()
      M.register_program(program, true)
    end,
  })
end

M.done = function()
  done = true
end

M.check = function()
  vim.health.start("nobbz")
  if done then
    vim.health.ok("Config loaded completely")
  else
    vim.health.warn("Config *not* loaded completely")
  end

  check_programs()
end

return M
