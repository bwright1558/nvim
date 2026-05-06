vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = "qf",
  group = vim.api.nvim_create_augroup("user_plugins_bqf", { clear = true }),
  callback = function()
    vim.pack.add({
      "https://github.com/kevinhwang91/nvim-bqf",
    }, { confirm = false })
    require("bqf").setup({
      preview = {
        winblend = 0,
        auto_preview = true,
        border = "rounded",
        show_title = true,
        show_scroll_bar = true,
        delay_syntax = 50,
        win_height = 15,
        win_vheight = 15,
        wrap = false,
        buf_label = true,
        should_preview_cb = function()
          return true
        end,
      },
    })

    -- Fix timing issue with lazy loading by filetype and vim.pack. This line is not needed when otherwise.
    vim.cmd.runtime("after/ftplugin/qf/bqf.vim")
  end,
})
