local function is_always_hidden(name)
  if name == ".git" then return true end

  return false
end

require("oil").setup({
  columns = { "icon", "permissions", "size", "mtime", },
  view_options = {
    show_hidden = true,
    is_always_hidden = is_always_hidden,
  },
})

WK.add({
  { "<leader>o",  group = "oil file explorer", },
  { "<leader>o.", "<cmd>Oil<cr>",              desc = "open current folder", },
})
