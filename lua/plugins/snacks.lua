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
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    git = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
  },
}

return M
