local M = {
  "akinsho/toggleterm.nvim",
  keys = { "<C-;>" },
}

function M.config()
  local border = require("user.borders").style

  require("toggleterm").setup({
    size = 20,
    open_mapping = [[<C-;>]],
    direction = "float",
    highlights = {
      Normal = { link = "NormalFloat" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
    },
    float_opts = {
      border = border,
    },
  })
end

return M
