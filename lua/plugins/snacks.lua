vim.pack.add({
  "https://github.com/folke/snacks.nvim",
}, { confirm = false })

require("snacks").setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  git = { enabled = true },
  image = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = true },
  terminal = { enabled = true },
  words = { enabled = true },
})

-- Autocmd to refresh indent guides after opening a window or filetype detection.
-- This is a workaround because Snacks.indent doesn't enable on its own when opening a new file.
-- local group = vim.api.nvim_create_augroup("user_config_snacks_indent_fix", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
--   group = group,
--   callback = function()
--     Snacks.indent.enable()
--   end,
-- })
