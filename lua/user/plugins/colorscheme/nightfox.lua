local M = {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  -- Nightfox border background is not set by default. We override this option here.
  -- TODO: Consider using a dimmer border foreground like `fg = "bg4"` (telescope default).
  local border = { fg = "fg3", bg = "bg0" }
  local normal = { fg = "fg1", bg = "bg0" }

  -- Make float backgrounds darker than the editing area.
  local groups = {
    all = {
      NormalFloat = normal,
      FloatBorder = border,

      TelescopeNormal = normal,
      TelescopeBorder = border,

      BqfPreviewFloat = normal,
      BqfPreviewBorder = border,
    },
  }

  require("nightfox").setup({
    groups = groups,
  })

  vim.cmd.colorscheme("nightfox")
end

return M
