local M = {
  "lukas-reineke/indent-blankline.nvim",
}

function M.config()
  local icons = require("user.icons")

  require("indent_blankline").setup({
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
end

return M
