-- gitsigns.lua
--
-- See: https://github.com/lewis6991/gitsigns.nvim

local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    current_line_blame = true,
    preview_config = {
      border = "rounded",
    },
  },
}

return M
