local luasnip = require("luasnip")
local wk = require("which-key")

local function choice(step)
  return function()
    if luasnip.choice_active() then
      luasnip.change_choice(step)
    end
  end
end

wk.register({
  ["<S-e>"] = { luasnip.expand, "expand" },
}, { mode = "i" })

wk.register({
  ["<S-b>"] = { luasnip.step(1), "next snippet gap" },
  ["<S-v>"] = { luasnip.step(-1), "previous snippet gap" },
  ["<S-a>"] = { choice(1), "next choice" },
  ["<S-s>"] = { choice(-1), "previous choice" },
}, { mode = { "i", "s" } })
