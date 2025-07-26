-- mason.lua
--
-- Sets up core configuration for mason.nvim.
-- Used by lspconfig, formatter, and linter installers.
--
-- See: https://github.com/mason-org/mason.nvim

local M = {
  "mason-org/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
    },
  },
}

return M
