return function(client, buffer)
  require("nobbz.lsp.keymap")(client, buffer)

  vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach" }, {
    buffer = buffer,
    callback = vim.lsp.codelens.refresh,
  })

  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
  end
end
