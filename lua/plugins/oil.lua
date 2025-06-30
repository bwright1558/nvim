-- oil.lua
--
-- Buffer-like file explorer.
--
-- See: https://github.com/stevearc/oil.nvim

local M = {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
}

return M
