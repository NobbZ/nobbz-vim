local M = {}

function M.git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()

  result = result:gsub("%s+$", "") -- trim trailing whitespace

  if result == "" then
    return nil
  end

  return result
end

return M
