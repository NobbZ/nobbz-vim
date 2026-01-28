local helpers = require("nobbz.lsp.helpers")

local function on_attach(_, buffer)
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format({
        async = false,
        bufnr = buffer,
      })
    end,
  })
end

-- this snippet is adopted from:
-- https://github.com/neovim/nvim-lspconfig/blob/37f362ef42d1a604d332e8d3d7d47593852b4313/doc/server_configurations.md#lua_ls
local function on_init(client)
  local path = client.workspace_folders[1].name

  -- Search in project for a `.luarc.json` or `.luarc.jsonc`, do nothing if found.
  local luarc_json_path = vim.fs.joinpath(path, ".luarc.json")
  local luarc_json_exists = vim.fn.glob(luarc_json_path) ~= ""
  local luarc_jsonc_path = vim.fs.joinpath(path, ".luarc.jsonc")
  local luarc_jsonc_exists = vim.fn.glob(luarc_jsonc_path) ~= ""
  if luarc_json_exists or luarc_jsonc_exists then return end

  -- if there is a luarc.lua in the workspace root, import and merge.
  local glob_path = vim.fs.joinpath(path, "plugins", "*", "lua")
  local plugin_paths = vim.split(vim.fn.glob(glob_path), "\n", { trimempty = true, })
  plugin_paths = vim.iter(plugin_paths):map(function(plugin_path) return string.sub(plugin_path, -1, -4) end)
  table.insert(plugin_paths, vim.env.VIMRUNTIME)

  -- Assume we are in a nvim config and configure appropriately to not warn on nvim globals
  client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
    runtime = { version = "LuaJIT", },
    -- Make the server aware of Neovim runtime files
    workspace = {
      checkThirdParty = false,
      library = plugin_paths,
    },
  })
end

return {
  name = "lua_ls",
  ft = "lua",
  on_attach = { helpers.default, on_attach, },
  on_init = on_init,
  settings = {
    Lua = {
      hint = { enable = true, },
    },
  },
}
