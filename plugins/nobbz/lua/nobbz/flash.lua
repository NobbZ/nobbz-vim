require("nobbz.lazy").add_specs({ {
  "flash",
  after = function()
    local flash = require("flash")

    flash.setup({})

    WK.add({
      { "s", function() flash.jump({}) end,       desc = "flash jump", },
      { "S", function() flash.treesitter({}) end, desc = "flash treesitter", },
    })
  end,
  keys = {
    { "s", mode = "n", },
    { "S", mode = "n", },
  },
}, })
