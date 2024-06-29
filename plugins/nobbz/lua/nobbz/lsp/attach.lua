---Refreshes the codelenses in the current buffer, if the connected LSP supports
---codelenses.
---@param client vim.lsp.Client
---@return function
local function refresh_codelens(client)
  return function(args)
    if client.supports_method("textDocument/codelens") then vim.lsp.codelens.refresh(args) end
  end
end

---@param client vim.lsp.Client
---@param buffer integer
local function on_attach(client, buffer)
  require("nobbz.lsp.keymap")(client, buffer)

  vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
    buffer = buffer,
    callback = refresh_codelens(client),
  })

  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

  if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = buffer }) end
end

return on_attach
