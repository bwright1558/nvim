local M = {
  "williamboman/mason.nvim",
}

M.config = function()
  local border = require("user.borders").style

  require("mason").setup({
    ui = {
      border = border,
    },
  })
end

return M
