local lualine = require("lualine")

local function treesitter_status()
  local highlighter = require("vim.treesitter.highlighter")
  local buf = vim.api.nvim_get_current_buf()

  local has_parser = pcall(function()
    return vim.treesitter.get_parser(buf):lang()
  end)

  if not has_parser then return ": ✗" end
  if highlighter.active[buf] then return ": ✓" end
  return ": ○"
end

local filename = {
  "filename",
  symbols = {
    modified = "[]",
    readonly = "[]",
  },
}

lualine.setup({
  theme = "catppuccin",
  sections = {
    lualine_c = {
      filename,
    },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      treesitter_status,
    },
  },
})
