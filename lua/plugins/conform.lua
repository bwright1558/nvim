-- conform.lua
--
-- Provides formatting support for multiple filetypes.
-- Use mason-tool-installer to install formatters automatically.
--
-- See: https://github.com/stevearc/conform.nvim

local M = {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 30000,
      -- lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      python = { "isort" },
      rust = { "rustfmt" },
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
    },
  },
}

return M
