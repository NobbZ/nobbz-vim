local M = {}

local programs = {}
local lsp_configs = {}
local done = false

local CRITICALITY = { OK = 1, ERROR = 2, WARN = 3, NOTICE = 4, }

---Checks if a program is available in the system `PATH`
---@param program string the program to check
---@return boolean whether the program is in the `PATH`
local function in_path(program)
  return vim.fn.executable(program) == 1
end

local function health_cmp(a, b)
  -- Sort by program name, if same criticality
  if a[4] == b[4] then return a[1] < b[1] end

  -- Sort by criticality otherwise
  return a[4] < b[4]
end

local function healt_sort(tbl)
  table.sort(tbl, health_cmp)
end

local function report_table(tbl)
  for _, info in ipairs(tbl) do
    local report_func = info[2]
    local label = info[1]
    local msg = info[3]

    local message = string.format("`%s` %s", label, msg)

    report_func(message)
  end
end


---Performs health checks for all registered LSP configs
---Displays results sorted by criticality and then alphabetically
local function check_lspconfigs()
  local configs = {}

  vim.health.start("LSP Configurations:")
  for lsp, available in pairs(lsp_configs) do
    if available then
      table.insert(configs, { lsp, vim.health.ok, "is configured", CRITICALITY.OK, })
    else
      table.insert(configs, { lsp, vim.health.error, "is not configured", CRITICALITY.ERROR, })
    end
  end

  healt_sort(configs)
  report_table(configs)
end


---Performs health checks for all registered programs
---Displays results sorted by criticality and then alphabetically
local function check_programs()
  local binaries = {}

  vim.health.start("Programs in `PATH`:")
  for program, required in pairs(programs) do
    if in_path(program) then
      table.insert(binaries, { program, vim.health.ok, "is installed", CRITICALITY.OK, })
    elseif required then
      table.insert(binaries, { program, vim.health.error, "is not installed", CRITICALITY.ERROR, })
    else
      table.insert(binaries, { program, vim.health.info, "is not installed", CRITICALITY.NOTICE, })
    end
  end

  healt_sort(binaries)
  report_table(binaries)
end

---Registers a program for the healthcheck, the program will be searched in the
---`PATH`.
---
---If a program is registered for a second time, the `required` will be overwritten.
---
---@param program string the name of the program
---@param required_or_filetypes (boolean | string[]) whether the program is required (missing programs
---  will issue an error when required, a warning otherwise)
M.register_program = function(program, required_or_filetypes)
  if type(required_or_filetypes) == "table" then
    M.register_program(program, false)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = required_or_filetypes,
      callback = function()
        M.register_program(program, true)
      end,
    })
    return
  end

  programs[program] = required_or_filetypes
end

---Unregisters a program from the healthcheck
---@param program string the program to unregister, it will not be checked by
---  the healthcheck anymore
M.unregister_program = function(program)
  programs[program] = nil
end

---Registers an LSP server for healthcheck
---Automatically registers the LSP binary as optional by default,
---but makes it required when a relevant filetype is opened
---@param lsp string the name of the LSP server as defined in lspconfig
M.register_lsp = function(lsp)
  local config = vim.lsp.config[lsp]

  lsp_configs[lsp] = not not config
  if not config then return end

  local program = config.cmd[1]
  local patterns = config.filetypes

  M.register_program(program, patterns)
end

---Marks the configuration as completely loaded
---This affects the health check status message
M.done = function()
  done = true
end

---Runs all registered health checks, usually called by `:checkhealth`.
---Displays overall configuration status and checks all registered programs
M.check = function()
  vim.health.start("nobbz")
  if done then
    vim.health.ok("Config loaded completely")
  else
    vim.health.warn("Config *not* loaded completely")
  end

  check_lspconfigs()
  check_programs()
end

return M
