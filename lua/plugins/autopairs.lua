vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  group = vim.api.nvim_create_augroup("user_plugins_autopairs", { clear = true }),
  callback = function()
    vim.pack.add({
      "https://github.com/windwp/nvim-autopairs",
    }, { confirm = false })

    require("nvim-autopairs").setup({
      check_ts = true,
      fast_wrap = {},
    })
  end,
})
