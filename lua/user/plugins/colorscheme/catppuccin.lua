local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("catppuccin").setup({
    flavour = "mocha",
    custom_highlights = function(C)
      local normal_float = { fg = C.text, bg = C.mantle }
      local float_border = { fg = C.blue, bg = C.mantle }

      return {
        NormalFloat = normal_float,
        FloatBorder = float_border,

        TelescopeNormal = normal_float,
        TelescopeBorder = float_border,

        BqfPreviewFloat = normal_float,
        BqfPreviewBorder = float_border,
      }
    end,
  })

  vim.cmd.colorscheme("catppuccin")
end

return M
