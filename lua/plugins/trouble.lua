vim.defer_fn(function()
  vim.pack.add({
    "https://github.com/folke/trouble.nvim",
  }, { confirm = false })

  require("trouble").setup({})
end, 100)
