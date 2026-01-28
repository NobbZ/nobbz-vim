local SCALE_FACTOR = 1.1
local FONT = "Departure Mono"
local FONT_SIZE = 11
local DEFAULT_SCALE = 0.6

vim.o.guifont = string.format("%s:%d", FONT, FONT_SIZE)

vim.g.neovide_scale_factor = DEFAULT_SCALE

local function neovide_scale_factor(factor)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
end

local function scale_up()
  neovide_scale_factor(SCALE_FACTOR)
end

local function scale_down()
  neovide_scale_factor(1 / SCALE_FACTOR)
end

require("which-key").add({
  { "<C-+>",      scale_up,   desc = "increase font scale", },
  { "<C-->",      scale_down, desc = "decrease font scale", },
  { "<C-kPlus>",  scale_up,   desc = "increase font scale", },
  { "<C-kMinus>", scale_down, desc = "decrease font scale", },
})
