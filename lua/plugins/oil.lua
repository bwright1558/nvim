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
    keymaps = {
      ["<C-s>"] = false,             -- default is "actions.select" veritical split
      ["<C-h>"] = false,             -- default is "actions.select" horizontal split
      ["<C-j>"] = false,             -- no default
      ["<C-k>"] = false,             -- no default
      ["<C-l>"] = false,             -- default is "actions.refresh"
      ["<C-r>"] = "actions.refresh", -- no default
    },
  },
}

return M
