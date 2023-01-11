local M = {
  "beauwilliams/focus.nvim",
}

M.config = function()
  require("focus").setup({
    autoresize = false,
    signcolumn = false,
  })
end

return M
