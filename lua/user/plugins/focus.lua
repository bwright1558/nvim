local M = {
  "beauwilliams/focus.nvim",
  event = "VeryLazy",
}

function M.config()
  require("focus").setup({
    autoresize = false,
    signcolumn = false,
  })
end

return M
