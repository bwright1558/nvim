-- toggleterm.lua
--
-- Easily manage multiple terminal windows.
--
-- See: https://github.com/akinsho/toggleterm.nvim

local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = "<Leader>;",
    float_opts = {
      border = "rounded",
    },
  },
}

return M
