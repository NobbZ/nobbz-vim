local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup({
  --on_attach = default_on_attach,

  -- this snippet is adopted from:
  -- https://github.com/neovim/nvim-lspconfig/blob/37f362ef42d1a604d332e8d3d7d47593852b4313/doc/server_configurations.md#lua_ls
  on_init = function(client)
    local path = client.workspace_folders[1].name

    -- Search in project for a `.luarc.json` or `.luarc.jsonc`, do nothing if found.
    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then return end

    -- Assume we are in a nvim config and configure appropriately to not warn on nvim globals
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT" },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
  settings = { Lua = {} },
  capabilities = capabilities,
})
