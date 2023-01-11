local M = {
  "williamboman/mason.nvim",
}

function M.config()
  local border = require("user.borders").style

  require("mason").setup({
    ui = {
      border = border,
    },
  })
end

return M
