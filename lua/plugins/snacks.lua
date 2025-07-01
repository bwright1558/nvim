-- snacks.lua
--
-- A collection of QoL plugins for neovim.
--
-- See: https://github.com/folke/snacks.nvim

local M = {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
    git = { enabled = true },
    notifier = { enabled = true },
  },
}

return M
