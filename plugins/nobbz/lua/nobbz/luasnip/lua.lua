local fun_string = [[function {}({})
  {}
end]]

local module_string = [[local M = {{}}

function M.{}({})
  {}
end

return M]]

local module_fun_string = [[function M.{}({})
  {}
end]]

return {
  s({ trig = "fn", name = "function", desc = "function definition", }, fmt(fun_string, { i(1, "name"), i(2), i(0), })),
  s({ trig = "fnM", name = "module function", desc = "function definition in module", },
    fmt(module_fun_string, { i(1, "name"), i(2), i(0), })),
  s({ trig = "mod", name = "module", desc = "module definition", },
    fmt(module_string, { i(1, "name"), i(2, "func"), i(0), })),
}
