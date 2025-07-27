-- conform.lua
--
-- Provides formatting support for multiple filetypes.
-- Use mason-tool-installer to install formatters automatically.
--
-- See: https://github.com/stevearc/conform.nvim

local M = {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    format_on_save = function(bufnr)
      -- Disable autoformat on certain filetypes
      -- This prevents autoformat for the specified filetypes, but the configured
      -- formatter can still be used when the document is formatted manually (by user command or keymap).
      local ignore_filetypes = {
        "lua",
      }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end

      -- By setting `lsp_format = "never"`, conform will only format the
      -- file type using the formatter specified in `formatters_by_ft`.
      return { timeout_ms = 30000, lsp_format = "never" }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      go = { "goimports", "gofumpt" },
      python = { "isort" },
      rust = { "rustfmt" },
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      graphql = { "prettierd" },
      markdown = { "prettierd" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      jsx = { "prettierd" },
      vue = { "prettierd" },
    },
  },
}

return M
