return {
  "akinsho/toggleterm.nvim",
  config = function()
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
  end,
}
