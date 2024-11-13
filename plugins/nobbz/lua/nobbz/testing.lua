local neotest = require("neotest")
local neotest_elixir = require("neotest-elixir")
local neotest_rust = require("neotest-rust")

-- do not specify a type here, the intention is that this is a `neotest.Config`,
-- though due to a faulty type this would make typechecking fail. Optional keys
-- are not specified as optional in the config (for a reason), but they should
-- be in the argument to `neotest.setup()`.
local neotest_config = {
  adapters = {
    neotest_elixir,
    neotest_rust,
  },
}

neotest.setup(neotest_config)

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

WK.add({
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
