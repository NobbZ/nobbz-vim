return {
  s({ trig = "external", name = "external definition", desc = "external reference", },
    fmt([[
      @external({}, "{}", "{}")
      pub fn {}({}) -> {}
    ]], {
      c(1, { t("erlang"), t("javascript"), }),
      i(2, "module"),
      i(3, "function"),
      i(4, "name"),
      i(5, "args"),
      i(0, "return"),
    })
  ),
}
