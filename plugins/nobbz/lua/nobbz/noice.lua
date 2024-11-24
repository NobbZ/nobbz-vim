require("noice").setup({
  lsp = {
    -- override markdown rendering so that **com** and other plugins use **trees**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    messages = { enabled = true, },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  views = {
    cmdline_popup = {
      position = {
        col = "50%",
        row = "85%",
      },
    },
  },
})
