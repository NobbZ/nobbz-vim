vim.o.guifont = "Departure Mono:11"

vim.g.neovide_scale_factor = 0.6

local base_factor = 1.1

local function neovide_scale_factor(factor)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
end

local function scale_up()
  neovide_scale_factor(base_factor)
end

local function scale_down()
  neovide_scale_factor(1 / base_factor)
end

WK.add({
  { "<C-+>",      scale_up,   desc = "increase font scale", },
  { "<C-->",      scale_down, desc = "decrease font scale", },
  { "<C-kPlus>",  scale_up,   desc = "increase font scale", },
  { "<C-kMinus>", scale_down, desc = "decrease font scale", },
})
