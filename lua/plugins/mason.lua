-- mason.lua
--
-- This plugin configures mason.nvim, which provides a portable package manager
-- for installing and managing LSP servers, DAP servers, linters, and formatters.
--
-- See: https://github.com/mason-org/mason.nvim

local M = {
  "mason-org/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
    },
  },
}

return M
