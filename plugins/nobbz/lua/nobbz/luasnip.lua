local luasnip = require("luasnip")
local lualoader = require("luasnip.loaders.from_lua")

luasnip.config.setup({
  enable_autosnippets = true,
})

WK.add({
  { "<C-k>", luasnip.expand, desc = "expand snippet", },
})

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

vim.api.nvim_create_user_command("SnipList", list_snips, {})

lualoader.load({ paths = script_path("luasnip"), })
