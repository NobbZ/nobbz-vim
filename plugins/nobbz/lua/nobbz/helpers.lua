local M = {}

---Retrieves the root of the current git repository/workspace
---
---If git is not installed, it will search from PWD upwards, until it finds
---a file, link, or folder called `.git`, this is very rudimentary and errorprone.
---
---@return string|nil path The path of the git-root, or `nil` if not in a git
---  repository or not found.
function M.git_root()
  if vim.fn.executable("git") ~= 1 then
    return vim.fs.root(vim.fn.getcwd(), ".git")
  end

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
