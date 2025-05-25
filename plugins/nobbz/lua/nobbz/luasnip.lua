local luasnip = require("luasnip")

---returns a function that steps a choice if available by `step`
---@param step integer
---@return function
local function choice(step)
  return function()
    if luasnip.choice_active() then luasnip.change_choice(step) end
  end
end

---returns a function that steps through template gaps by `step_size`
---@param step_size integer
---@return function
local function stepper(step_size)
  return function()
    if luasnip.jumpable(step_size) then
      luasnip.jump(step_size)
    else
      return step_size > 0 and "<Tab>" or "<S-Tab>"
    end
  end
end

WK.add({
  { "<Tab>",   stepper(1),     desc = "next snippet gap",     mode = { "s", "i", }, expr = true, },
  { "<S-Tab>", stepper(-1),    desc = "previous snippet gap", mode = { "s", "i", }, expr = true, },
  { "<C-a>",   choice(1),      desc = "next choice",          mode = { "s", "i", }, },
  { "<C-s>",   choice(-1),     desc = "previous choice",      mode = { "s", "i", }, },
  { "<C-e>",   luasnip.expand, desc = "expand snippet",       mode = "s", },
})
