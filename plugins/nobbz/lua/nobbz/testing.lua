local neotest = require("neotest")
local neotest_elixir = require("neotest-elixir")
local wk = require("which-key")

require("neotest").setup({
  adapters = {
    require("neotest-elixir"),
  },
})

local function run_all()
  neotest.run.run({ suite = true, })
end

local function run_file()
  neotest.run.run(vim.fn.expand("%"))
end

local function watch_all()
  neotest.watch.watch({ suite = true, })
end

local function watch_file()
  neotest.watch.watch(vim.fn.expand("%"))
end

wk.add({
  { "<leader>t",   group = "tests", },
  { "<leader>tt",  neotest.run.run,        desc = "run nearest", },
  { "<leader>tf",  run_file,               desc = "run file", },
  { "<leader>ta",  run_all,                desc = "run all", },
  { "<leader>ts",  neotest.summary.toggle, desc = "toggle summary", },
  { "<leader>tw",  group = "watch", },
  { "<leader>tww", neotest.watch.watch,    desc = "watch nearest", },
  { "<leader>twf", watch_file,             desc = "watch file", },
  { "<leader>twa", watch_all,              desc = "watch all", },
})
