vim.g.cord_defer_startup = true;

local function logger(name)
  return function(opts)
    local message = string.format("%s: %s", name, vim.inspect(opts))
    vim.notify_once(message)
    return name
  end
end

local function is_work_related(opts)
  return opts.workspace_dir:find("nightwing", 1, nil) ~= nil or opts.workspace_dir:find("BravoBike", 1, nil) ~= nil
end

local function workspace(opts)
  if is_work_related(opts) then return "Jobrelated workspace" end

  return ("in workspace %s"):format(opts.workspace)
end

local function edit(opts)
  if is_work_related(opts) then return "editing unknown file" end

  local verb = "editing"
  if opts.is_read_only then
    verb = "viewing"
  end

  return ("%s %s (%s)"):format(verb, opts.filename, opts.filetype)
end

local function docs(opts)
  return ("reading docs about %s"):format(opts.name)
end

local function file_browser(opts)
  if is_work_related(opts) then return "browsing in unknown folder" end

  return ("browsing in %s"):format(opts.tooltip)
end

require("nobbz.lazy").add_specs({ {
  "cord.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("cord").setup({
      enabled = true,
      log_level = "debug",
      editor = {
        client = "1469629275526266910",
        tooltip = "Editting like a NobbZ",
      },
      display = {
        theme = "catppuccin",
        flavor = "dark",
        view = "auto",
      },
      idle = {
        enabled = false,
      },
      advanced = {
        discord = {
          sync = {
            enabled = true,
            mode = "defer",
            interval = 12000, -- in millisecs
          },
        },
      },
      text = {
        default = "Using NobbZvim",
        workspace = workspace,
        viewing = edit,
        editing = edit,
        file_browser = file_browser,
        plugin_manager = nil,
        lsp = nil,
        docs = docs,
        vcs = "doing version control",
        notes = nil,
        debug = nil,
        test = nil,
        diagnostics = "checking diagnostics",
        games = nil,
        terminal = nil,
        dashboard = nil,
      },
    })
  end,
}, })
