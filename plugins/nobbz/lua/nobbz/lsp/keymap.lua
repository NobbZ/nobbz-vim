---Triggers a reformat of the current buffer when called
local function format_buffer() vim.lsp.buf.format({ async = true, }) end

---Registers the default keymap as intended for LSP powered buffers.
---@param client vim.lsp.Client
---@param buffer integer
local function attach_keymap(client, buffer) ---@diagnostic disable-line:unused-local
  WK.add({
    { "<leader>l",   group = "language server", },
    { "<leader>lg",  group = "goto", },
    { "<leader>lgD", vim.lsp.buf.declaration,     desc = "jump to declaration", },
    { "<leader>lgd", vim.lsp.buf.definition,      desc = "jump to definition", },
    { "<leader>lgt", vim.lsp.buf.type_definition, desc = "jump to type definition", },
    { "<leader>lgn", vim.diagnostic.goto_next,    desc = "jump to next diagnostic", },
    { "<leader>lgp", vim.diagnostic.goto_prev,    desc = "jump to prev diagnostic", },
    { "<leader>lh",  vim.lsp.buf.hover,           desc = "show hover info", },
    { "<leader>ls",  vim.lsp.buf.signature_help,  desc = "show signature info", },
    { "<leader>lr",  vim.lsp.buf.rename,          desc = "rename symbol", },
    { "<leader>lf",  format_buffer,               desc = "format buffer", },
    { "<c-.>",       vim.lsp.buf.code_action,     desc = "show code actions", },
  })
end

return attach_keymap
