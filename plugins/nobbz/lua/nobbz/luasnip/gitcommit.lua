vim.print("luasnip loading")

return {
  s({ trig = "sc", desc = "short-cut ticket", },
    { t("[SC-"), i(1), t("]"), i(2), }),
}
