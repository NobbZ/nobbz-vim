local filetypes = { "markdown", "markdown.mdx", }

local checkbox_query = vim.treesitter.query.parse(
  "markdown",
  [[
    [
      (task_list_marker_unchecked)
      (task_list_marker_checked)
    ] @checkbox
  ]]
)
local function toggle_markdown_checkbox()
  local bufnr = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1] - 1
  local cursor_col = pos[2]

  local parser = vim.treesitter.get_parser(bufnr, "markdown")
  if not parser then
    vim.print({ "parser unavailable", parser, })
    return
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in checkbox_query:iter_captures(root, bufnr, row, row + 1) do
    if checkbox_query.captures[id] == "checkbox" then
      local start_row, start_col, end_row, end_col = node:range()

      local replacement
      if node:type() == "task_list_marker_checked" then
        replacement = "[ ]"
      else
        replacement = "[x]"
      end

      vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { replacement, })

      vim.api.nvim_win_set_cursor(0, { row + 1, cursor_col, })
      -- this return stops iteration after modification, to avoid working on a stale tree
      return
    end
  end
end

require("nobbz.lazy").add_specs({ {
  "markdown",
  ft = filetypes,
  after = function()
    require("markdown").setup({})

    require("which-key").add({
      { "<leader>mct", toggle_markdown_checkbox, desc = "Toggle checkbox", },
    })
  end,
}, {
  "nabla",
  ft = filetypes,
  keys = {
    { "<leader>ne", mode = { "n", }, },
    { "<leader>nd", mode = { "n", }, },
    { "<leader>nt", mode = { "n", }, },
    { "<leader>nn", mode = { "n", }, },
    { "<leader>np", mode = { "n", }, },
  },
  after = function()
    local nabla = require("nabla")

    local virt_opts = {
      autogen = true, -- auto-regenerate ASCII art when exiting inserting mode
      silent = true,  -- silence error messages
    }

    local function enable() nabla.enable_virt(virt_opts) end

    local function disable() nabla.disable_virt() end

    local function toggle() nabla.toggle_virt(virt_opts) end

    local function popup() nabla.popup() end

    require("which-key").add({
      { "<leader>n",  group = "nabla", },
      { "<leader>ne", enable,          desc = "Enable nabla inline", },
      { "<leader>nd", disable,         desc = "Disable nabla inline", },
      { "<leader>nt", toggle,          desc = "Toggle nabla inline", },
      { "<leader>nn", toggle,          desc = "Toggle nabla inline", },
      { "<leader>np", popup,           desc = "Show nabla popup", },
    })
  end,
}, })
