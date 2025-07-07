-- bqf.lua
--
-- Adds a preview window for items in the quickfix window.
--
-- See: https://github.com/kevinhwang91/nvim-bqf

local M = {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  opts = {
    preview = {
      winblend = 0,
    },
  },
}

return M
