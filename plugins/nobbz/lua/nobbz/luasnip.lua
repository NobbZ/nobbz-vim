local luasnip = require("luasnip")
local wk = require("which-key")

local function choice(step)
  return function()
    if luasnip.choice_active() then
      luasnip.change_choice(step)
    end
  end
end

local function stepper(step_size)
  return function() luasnip.jump(step_size) end
end

local selection_map = {
  ["<Tab>"] = { stepper(1), "next snippet gap" },
  ["<S-Tab>"] = { stepper(-1), "previous snippet gap" },
  ["<C-a>"] = { choice(1), "next choice" },
  ["<C-s>"] = { choice(-1), "previous choice" },
}

local interactive_map = {
  ["<C-e>"] = { luasnip.expand, "expand" },
}
for k, v in pairs(selection_map) do
  interactive_map[k] = v
end

wk.register(interactive_map, { mode = "i" })

wk.register(selection_map, { mode = "s" })
