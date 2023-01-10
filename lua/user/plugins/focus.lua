return {
  "beauwilliams/focus.nvim",
  config = function()
    require("focus").setup({
      autoresize = false,
      signcolumn = false,
    })
  end,
}
