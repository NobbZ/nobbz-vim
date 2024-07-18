local cmp = require("cmp")

local snippet = {
  expand = function(args) require("luasnip").lsp_expand(args.body) end,
}
local formatting = { format = require("lspkind").cmp_format(), }

local nvim_lsp = {
  name = "nvim_lsp",
  option = {
    markdown_oxide = {
      keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
    },
  },
}

---@diagnostic disable-next-line:redundant-parameter
cmp.setup({
  snippet = snippet,
  formatting = formatting,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true, }),
  }),
  sources = cmp.config.sources({
    nvim_lsp,
    { name = "buffer",  max_item_count = 5, }, -- text within current buffer
    { name = "path",    max_item_count = 3, }, -- file system paths
    { name = "luasnip", max_item_count = 3, }, -- snippets
    { name = "hledger", },
  }),
  experimental = {
    ghost_text = true,
  },
})
