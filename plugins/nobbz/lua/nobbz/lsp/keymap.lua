local wk = require("which-key")

---Registers the default keymap as intended for LSP powered buffers.
---@param client vim.lsp.Client
---@param buffer integer
local function attach_keymap(client, buffer) ---@diagnostic disable-line:unused-local
  wk.register({
    name = "language server",
    ["gD"] = { vim.lsp.buf.declaration, "jump to declaratin", },
    ["gd"] = { vim.lsp.buf.definition, "jump to definition", },
    ["gt"] = { vim.lsp.buf.type_definition, "jump to type definition", },
    ["gn"] = { vim.diagnostic.goto_next, "jump to next diagnostic message", },
    ["gp"] = { vim.diagnostic.goto_prev, "jump to previous diagnostic message", },
    ["h"] = { vim.lsp.buf.hover, "show hover info", },
    ["s"] = { vim.lsp.buf.signature_help, "show signature help", },
    ["r"] = { vim.lsp.buf.rename, "rename symbol", },
    ["f"] = { function() vim.lsp.buf.format({ async = true, }) end, "format buffer", },
  }, { prefix = "<leader>l", })

  wk.register({
    ["<C-.>"] = { vim.lsp.buf.code_action, "show code actions", },
  })
end

return attach_keymap
