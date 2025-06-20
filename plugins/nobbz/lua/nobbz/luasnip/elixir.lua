return {
  s({ trig = "def:", name = "def oneliner", desc = "one line function definition", },
    fmt("def {}({}), do: {}", { i(1, "name"), i(2, "args"), i(0, "body"), })),
  s({ trig = "defp:", name = "defp oneliner", desc = "one line private function definition", },
    fmt("defp {}({}), do: {}", { i(1, "name"), i(2, "args"), i(0, "body"), })),
  s({ trig = ">d", name = "pipe debug", desc = "pipe into debug", },
    fmt("|> dbg()")),
}
