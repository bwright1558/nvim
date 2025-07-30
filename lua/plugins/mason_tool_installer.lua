-- mason_tool_installer.lua
--
-- Automatically installs external tools (formatters, linters, DAPs)
-- using mason. Keeps them up to date on startup.
--
-- See: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  opts = {
    ensure_installed = {
      -- Formatters
      "gofumpt",
      "goimports",
      "isort",
      "ruff",
      "prettierd",
      "stylua",
      "shfmt",
    },
    auto_update = true,
    run_on_start = true,
  },
}

return M
