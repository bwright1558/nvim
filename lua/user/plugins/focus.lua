local M = {
  "beauwilliams/focus.nvim",
}

function M.config()
  require("focus").setup({
    autoresize = false,
    signcolumn = false,
  })
end

return M
