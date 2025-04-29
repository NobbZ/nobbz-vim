require("nobbz.lazy").add_specs({ {
  "ledger",
  ft = { "ledger", },
  after = function()
    local ledger = "hledger"
    if vim.fn.executable("ledger") == 1 then
      ledger = "ledger"
    end
    vim.g.ledger_command = ledger

    vim.g.ledger_fuzzy_account_completion = 1
    vim.g.ledger_date_format = "%Y-%m-%d"
    vim.g.ledger_align_at = 95
  end,
}, })
