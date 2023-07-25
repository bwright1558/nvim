local M = {
  "catppuccin/nvim",
  name = "catppuccin",
}

function M.config()
  require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    custom_highlights = function(C)
      local transparent_bg = { fg = C.text, bg = C.none }
      local normal_float = { fg = C.text, bg = C.mantle }
      local float_border = { fg = C.blue, bg = C.mantle }

      return {
        -- Manually set transparent background because
        -- Catppuccin's method (transparent_background option)
        -- will set transparency on elements that don't need
        -- transparency, e.g. lualine.
        Normal = transparent_bg,
        NormalNC = transparent_bg,

        -- Make line numbers more visibile against a transparent background.
        LineNr = { fg = C.overlay1 },

        -- Custom highlights on specific components.
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
