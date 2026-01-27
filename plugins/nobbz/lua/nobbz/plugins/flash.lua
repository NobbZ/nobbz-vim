require("nobbz.lazy").add_specs({ {
  "flash",
  after = function()
    local flash = require("flash")

    flash.setup({})

    require("which-key").add({
      { "s",     function() flash.jump({}) end,            desc = "flash jump",          mode = { "n", "x", "o", }, },
      { "S",     function() flash.treesitter({}) end,      desc = "flash treesitter",    mode = { "n", "o", }, },
      { "r",     function() flash.remote() end,            desc = "remote flash",        mode = { "o", }, },
      { "R",     function() flash.treesitter_search() end, desc = "treesitter search",   mode = { "x", "o", }, },
      { "<C-s>", function() flash.toggle() end,            desc = "toggle flash search", mode = { "c", }, },
    })
  end,
  keys = {
    { "s",     mode = { "n", "x", "o", }, },
    { "S",     mode = { "n", "o", }, },
    { "r",     mode = { "o", }, },
    { "R",     mode = { "x", "o", }, },
    { "<C-s>", mode = { "c", }, },
  },
}, })
