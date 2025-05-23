local filetypes = { "markdown", "markdown.mdx", }

require("nobbz.lazy").add_specs({ {
  "markdown",
  ft = filetypes,
  after = function()
    require("markdown").setup({})
  end,
}, {
  "nabla",
  ft = filetypes,
  keys = {
    { "<leader>ne", mode = { "n", }, },
    { "<leader>nd", mode = { "n", }, },
    { "<leader>nt", mode = { "n", }, },
    { "<leader>nn", mode = { "n", }, },
    { "<leader>np", mode = { "n", }, },
  },
  after = function()
    local nabla = require("nabla")

    local virt_opts = {
      autogen = true, -- auto-regenerate ASCII art when exiting inserting mode
      silent = true,  -- silence error messages
    }

    local function enable() nabla.enable_virt(virt_opts) end

    local function disable() nabla.disable_virt() end

    local function toggle() nabla.toggle_virt(virt_opts) end

    local function popup() nabla.popup() end

    require("which-key").add({
      { "<leader>n",  group = "nabla", },
      { "<leader>ne", enable,          desc = "Enable nabla inline", },
      { "<leader>nd", disable,         desc = "Disable nabla inline", },
      { "<leader>nt", toggle,          desc = "Toggle nabla inline", },
      { "<leader>nn", toggle,          desc = "Toggle nabla inline", },
      { "<leader>np", popup,           desc = "Show nabla popup", },
    })
  end,
}, })
