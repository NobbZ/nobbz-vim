require("nobbz.lazy").add_specs({ {
  "leap",
  after = function()
    WK.add({
      { "s",          "<Plug>(leap)",             desc = "biderctional leap in window", },
      { "S",          "<Plug>(leap-from-window)", desc = "leap in other windows", },
      { "<C-s>Left",  "<Plug>(leap-backward)",    desc = "leap backwards", },
      { "<C-s>Right", "<Plug>(leap-forward)",     desc = "leap forwards", },
    })
  end,
  keys = {
    { "s",          mode = { "n", "x", "o", }, },
    { "S",          mode = { "n", "x", "o", }, },
    { "<C-s>Left",  mode = { "n", "x", "o", }, },
    { "<C-s>Right", mode = { "n", "x", "o", }, },
  },
}, })
