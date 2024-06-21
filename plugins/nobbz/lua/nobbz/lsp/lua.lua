local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup({
  on_attach = require("nobbz.lsp.keymap"),

  -- this snippet is adopted from:
  -- https://github.com/neovim/nvim-lspconfig/blob/37f362ef42d1a604d332e8d3d7d47593852b4313/doc/server_configurations.md#lua_ls
  on_init = function(client)
    local path = client.workspace_folders[1].name

    -- Search in project for a `.luarc.json` or `.luarc.jsonc`, do nothing if found.
    local luarc_json_exists = vim.fn.glob(path .. "/.luarc.json") ~= ""
    local luarc_jsonc_exists = vim.fn.glob(path .. "/.luarc.jsonc") ~= ""
    if luarc_json_exists or luarc_jsonc_exists then return end

    -- if there is a luarc.lua in the workspace root, import and merge.
    local plugin_paths = vim.fn.glob(path .. "/plugins/*/lua")
    for i, plugin_path in pairs(plugin_paths) do
      plugin_paths[i] = vim.print(string.sub(plugin_path, -1, -4))
    end
    table.insert(plugin_paths, vim.env.VIMRUNTIME)

    -- Assume we are in a nvim config and configure appropriately to not warn on nvim globals
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT" },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = plugin_paths,
      },
    })
  end,
  settings = { Lua = {} },
  capabilities = capabilities,
})
