local helpers = require("nobbz.helpers")
local lualoader = require("luasnip.loaders.from_lua")
local luasnip = require("luasnip")
local select = require("luasnip.extras.select_choice")

luasnip.config.setup({
  enable_autosnippets = true,
})

local function cycle()
  if luasnip.choice_active() then
    return luasnip.change_choice(1)
  end
end

local function script_path(suffix)
  local path = debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  if suffix then return path .. suffix end
  return path
end

local function list_snips()
  local ft_list = luasnip.available()[vim.o.filetype]
  local ft_snips = {}
  for _, item in pairs(ft_list) do
    ft_snips[item.trigger] = item.desc
  end
  vim.print(ft_snips)
end

require("which-key").add({
  { "<C-e>",   luasnip.expand, desc = "expand snippet",            mode = { "i", "s", }, },
  { "<C-j>",   cycle,          desc = "Cycle choices in node",     mode = { "i", "s", }, },
  { "<C-S-j>", select,         desc = "UI select choices in node", mode = { "i", "s", }, },
})

vim.api.nvim_create_user_command("SnipList", list_snips, {})

local git_root = helpers.git_root()
local paths = { script_path("luasnip"), }
if git_root then
  vim.notify("git root: " .. git_root, vim.log.levels.INFO)
  table.insert(paths, git_root .. "/snippets")
end
table.insert(paths, "~/.config/nvim/snippets")

lualoader.load({ paths = paths, })
