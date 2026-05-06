vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = "lua",
  group = vim.api.nvim_create_augroup("user_plugins_lazydev", { clear = true }),
  callback = function()
    vim.pack.add({
      "https://github.com/folke/lazydev.nvim",
    }, { confirm = false })

    require("lazydev").setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    })
  end,
})
