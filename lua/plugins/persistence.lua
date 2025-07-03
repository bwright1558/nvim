-- persistence.lua
--
-- Simple session management for neovim.
--
-- See: https://github.com/folke/persistence.nvim

local M = {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
}

return M
