local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

local border = require("user.borders").style

toggleterm.setup({
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
