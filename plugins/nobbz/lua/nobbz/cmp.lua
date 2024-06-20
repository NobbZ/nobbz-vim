local cmp = require("cmp")

local snippet = {
  expand = function(args) require("luasnip").lsp_expand(args.body) end,
}
local formatting = { format = require("lspkind").cmp_format() }

cmp.setup({
  snippet = snippet,
  formatting = formatting,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "hledger" },
  }),
})
