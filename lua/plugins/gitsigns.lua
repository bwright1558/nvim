-- gitsigns.lua
--
-- See: https://github.com/lewis6991/gitsigns.nvim

local icons = require("config.icons")

local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = icons.ui.BoldLineLeft },
      change = { text = icons.ui.BoldLineLeft },
      delete = { text = icons.ui.Triangle },
      topdelete = { text = icons.ui.Triangle },
      changedelete = { text = icons.ui.BoldLineLeft },
      untracked = { text = icons.ui.BoldLineLeft },
    },
    current_line_blame = true,
    preview_config = {
      border = "rounded",
    },
  },
}

return M
