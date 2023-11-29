local M = {
  "lukas-reineke/indent-blankline.nvim",
}

function M.config()
  local icons = require("user.icons")

  require("ibl").setup({
    indent = { char = icons.ui.LineMiddle },
    exclude = {
      buftypes = { "terminal", "nofile", "nowrite" },
      filetypes = {
        "help",
        "dashboard",
        "packer",
        "lazy",
        "NvimTree",
        "Trouble",
        "text",
      },
    },
    scope = {
      show_start = true,
      show_end = false,
    },
  })
end

return M
