local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  return
end

local icons = require("user.icons")

indent_blankline.setup({
  buftype_exclude = { "terminal", "nofile", "nowrite" },
  filetype_exclude = {
    "help",
    "dashboard",
    "packer",
    "lazy",
    "NvimTree",
    "Trouble",
    "text",
  },
  char = icons.ui.LineMiddle,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = false,
})
