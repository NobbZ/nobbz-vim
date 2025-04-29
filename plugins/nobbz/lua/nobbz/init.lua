local lazy = require("nobbz.lazy")

WK = require("which-key")
-- TODO: make this available via lsp-helpers
LSP_CAPAS = require("blink.cmp").get_lsp_capabilities({
  textDocument = {
    foldingRange = {
      dynamicRegistration = true,
      lineFoldingOnly = true,
    },
  },
})

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
local function rs(submodule)
  return require(this_module .. "." .. submodule)
end

rs("augment")      -- Some AI thingy
rs("blink")        -- foundations for completions
rs("git")          -- set up neogit (kind of magit)
rs("leap")         -- some easier motions
rs("ledger")       -- set up ledger/hledger PTA
rs("lsp")          -- LSP and related setup
rs("lspsaga")      -- set up lspsaga
rs("lualine")      -- Set up the status bar at the bottom
rs("luasnip")      -- Snippet tool
rs("markdown")     -- Set up markdown editing
rs("mini")         -- set up mini.nvim
rs("misc")         -- miscelanous editor settings
rs("noice")        -- setup noice for nicer notifications and messages
rs("oil")          -- manage files as if it was a text buffer
rs("precognition") -- set up precognition, which helps with motions
rs("rainbow")      -- set up rainbow parenthesis
rs("surround")     -- gelps with surrounding in parens or quotes
rs("telescope")    -- some fuzzy finders
rs("theme")        -- how shall everything look like
rs("treesitter")   -- set up treesitter
rs("trouble")      -- load trouble
rs("ufo")          -- set up ufo
rs("whichkey")     -- set up whichkey, which provides help as you type

if vim.g.neovide then rs("neovide") end

lazy.add_specs({
  { "startuptime", command = "StartUptime", after = rf("nobbz.startuptime"), },
})

lazy.finish()

require("nobbz.health").done()
