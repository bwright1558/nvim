vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = "markdown",
  group = vim.api.nvim_create_augroup("user_plugins_render_markdown", { clear = true }),
  callback = function()
    vim.pack.add({
      -- Depends on nvim-treesitter and nvim-web-devicons
      "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    }, { confirm = false })

    require("render-markdown").setup({
      latex = { enabled = false },
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
    })
  end,
})
