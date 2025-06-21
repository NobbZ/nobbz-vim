local helpers = require("nobbz.lsp.helpers")

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

return {
  name = "mdx_analyzer",
  on_attach = { helpers.keymap, },
}
