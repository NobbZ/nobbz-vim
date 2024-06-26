require("nobbz.cmp")        -- foundations for completions
require("nobbz.git")        -- set up neogit (kind of magit)
require("nobbz.lsp")        -- LSP and related setup
require("nobbz.lualine")    -- Set up the status bar at the bottom
require("nobbz.luasnip")    -- Snippet tool
require("nobbz.markdown")   -- Set up markdown editing
require("nobbz.misc")       -- miscelanous editor settings
require("nobbz.noice")      -- setup noice for nicer notifications and messages
require("nobbz.oil")        -- manage files as if it was a text buffer
require("nobbz.telescope")  -- some fuzzy finders
require("nobbz.theme")      -- how shall everything look like
require("nobbz.treesitter") -- set up treesitter
require("nobbz.whichkey")   -- set up whichkey, which provides help as you type

require("lz.n").load({
  { "startuptime", command = "StartUptime", },
})
