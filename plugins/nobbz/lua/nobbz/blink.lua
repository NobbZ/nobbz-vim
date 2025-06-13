local blink = require("blink.cmp")
local luasnip = require("luasnip")

local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

blink.setup({
  snippets = {
    -- preset = "luasnip",
    active = function()
      if luasnip.in_snippet() and not blink.is_visible() then
        return true
      else
        if not luasnip.in_snippet() and vim.fn.mode() == "n" then luasnip.unlink_current() end
        return false
      end
    end,
  },
  -- I'd like to keep it enabled for search, while disabling for command line.
  -- see https://github.com/Saghen/blink.cmp/discussions/1580
  cmdline = { enabled = false, },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "omni", },
  },
  signature = {
    enabled = true,
    window = { border = "single", },
  },
  completion = {
    menu = {
      auto_show = function(ctx)
        return ctx ~= "cmdline"
      end,
      winhighlight = winhighlight,
      border = "single",
      draw = {
        treesitter = { "lsp", },
        columns = { { "kind_icon", }, { "label", "label_description", gap = 1, }, { "source_name", }, },
      },
    },
    ghost_text = { enabled = true, },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    documentation = {
      auto_show = true,
      window = {
        border = "single",
        winhighlight = winhighlight,
      },
      auto_show_delay_ms = 500,
    },
  },
  keymap = {
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation", },
    ["<C-e>"] = { "hide", "fallback", },
    ["<CR>"] = { "accept", "fallback", },
    ["<C-l>"] = { "select_next", "fallback", },
    ["<C-Down>"] = { "select_next", "fallback", },
    ["<C-h>"] = { "select_prev", "fallback", },
    ["<C-Up>"] = { "select_prev", "fallback", },
    ["<Tab>"] = { "snippet_forward", "fallback", },
    ["<S-Tab>"] = { "snippet_backward", "fallback", },
    ["<C-k>"] = { "scroll_documentation_up", "fallback", },
    ["<C-j>"] = { "scroll_documentation_down", "fallback", },
  },
})
