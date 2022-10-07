-- Use pcall because colorscheme plugin may not exist, yet.
pcall(function()
  vim.cmd [[colorscheme nightfox]]
end)
