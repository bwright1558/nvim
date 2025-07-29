-- ts_autotag.lua
--
-- Automatically closes and optionally renames matching tags in HTML, JSX, TSX, etc.
-- Integrates with Treesitter for context-aware behavior.
--
-- NOTE: Can cause performance issues in large or heavily nested files (esp. with enable_rename = true).
--
-- See: https://github.com/windwp/nvim-ts-autotag

local M = {
  "windwp/nvim-ts-autotag",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {},
}

return M
