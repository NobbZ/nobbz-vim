local cmp = require("cmp")
local _ = { behavior = cmp.SelectBehavior.Select, } -- prevent nvim-cmp from force-feeding completeions on 'Enter'
local luasnip = require("luasnip")


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
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true, }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
      end
    end,
  },
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
