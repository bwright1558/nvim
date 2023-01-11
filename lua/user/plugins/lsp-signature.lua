local M = {
  "ray-x/lsp_signature.nvim",
}

function M.config()
  local border = require("user.borders").style

  require("lsp_signature").setup({
    hint_enable = false,
    toggle_key = "<C-;>",
    handler_opts = {
      border = border,
    },
  })
end

return M
