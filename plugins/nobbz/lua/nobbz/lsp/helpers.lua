---Refreshes the codelenses in the current buffer, if the connected LSP supports
---codelenses.
---@param client vim.lsp.Client
---@param buffer integer
---@return function
local function refresh_codelens(client, buffer)
  return function(args)
    if client:supports_method("textDocument/codelens", buffer) then vim.lsp.codelens.refresh(args) end
  end
end

---Triggers a reformat of the current buffer when called
local function format_buffer() vim.lsp.buf.format({ async = true, }) end

---Registers the default keymap as intended for LSP powered buffers.
---@param client vim.lsp.Client
---@param buffer integer
local function keymap(client, buffer) ---@diagnostic disable-line:unused-local
  WK.add({
    { "<leader>l",   group = "language server", },
    { "<leader>lg",  group = "goto", },
    { "<leader>lgD", vim.lsp.buf.declaration,     desc = "jump to declaration", },
    { "<leader>lgd", vim.lsp.buf.definition,      desc = "jump to definition", },
    { "<leader>lgt", vim.lsp.buf.type_definition, desc = "jump to type definition", },
    { "<leader>lh",  vim.lsp.buf.hover,           desc = "show hover info", },
    { "<leader>ls",  vim.lsp.buf.signature_help,  desc = "show signature info", },
    { "<leader>lr",  vim.lsp.buf.rename,          desc = "rename symbol", },
    { "<leader>lf",  format_buffer,               desc = "format buffer", },
    { "<leader>l.",  vim.lsp.buf.code_action,     desc = "show code actions", },
  })
end

---The default LSP attach handler
---
---Sets up the default `keymap` as well as `codelenses`.
---
---If either of those doesn't work for you, please use the individual handlers.
---@param client vim.lsp.Client
---@param buffer integer
local function default(client, buffer)
  keymap(client, buffer)

  vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach", }, {
    buffer = buffer,
    callback = refresh_codelens(client, buffer),
  })

  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached", })

  if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = buffer, }) end
end

---@alias nobbz.lsp.helpers.Handler fun(client: vim.lsp.Client, buffer: integer) an `on_attach` handler.
---@alias Handler nobbz.lsp.helpers.Handler

---Iterates over all the given `handler`s and calls them in order of appearance.
---@param handler Handler | Handler[]
---@return Handler
local function combine(handler)
  if type(handler) ~= "table" then handler = { handler, } end

  return function(client, buffer)
    for _, handle_fun in ipairs(handler) do
      handle_fun(client, buffer)
    end
  end
end

return {
  combine = combine,
  default = default,
  keymap = keymap,
}
