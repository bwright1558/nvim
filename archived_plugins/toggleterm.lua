-- toggleterm.lua
--
-- Easily manage multiple terminal windows.
--
-- See: https://github.com/akinsho/toggleterm.nvim

local M = {
  "akinsho/toggleterm.nvim",
  enabled = false,
  version = "*",
  opts = {
    open_mapping = "<C-;>",
    float_opts = {
      border = "rounded",
    },
  },
}

return M
