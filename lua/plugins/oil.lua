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
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Oil" },
  },
  opts = {},
}

return M
