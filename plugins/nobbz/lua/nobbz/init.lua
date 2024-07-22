---A small helper function to lazily require.
---
---It is especially helpful together with
---@param modname string
---@return function
local function rf(modname)
  return function()
    require(modname)
  end
end

local this_module = ...

---A small helper function to require a submodule "relatively"
---@param submodule string
---@return unknown
local function require_sub(submodule)
  return require(this_module .. "." .. submodule)
end

require_sub("cmp")        -- foundations for completions
require_sub("git")        -- set up neogit (kind of magit)
require_sub("lsp")        -- LSP and related setup
require_sub("lualine")    -- Set up the status bar at the bottom
require_sub("luasnip")    -- Snippet tool
require_sub("markdown")   -- Set up markdown editing
require_sub("misc")       -- miscelanous editor settings
require_sub("nabla")      -- set up and load nabla (nice maths)
require_sub("noice")      -- setup noice for nicer notifications and messages
require_sub("oil")        -- manage files as if it was a text buffer
require_sub("rainbow")    -- set up rainbow parenthesis
require_sub("telescope")  -- some fuzzy finders
require_sub("theme")      -- how shall everything look like
require_sub("treesitter") -- set up treesitter
require_sub("whichkey")   -- set up whichkey, which provides help as you type

require("lz.n").load({
  { "startuptime", command = "StartUptime", after = rf("nobbz.startuptime"), },
})
