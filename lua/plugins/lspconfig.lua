-- lspconfig.lua
--
-- Automatically installs, configures, enables, and
-- starts language servers using lspconfig.
--
-- See: https://github.com/mason-org/mason-lspconfig.nvim
--      https://github.com/neovim/nvim-lspconfig

local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bashls",
      "cssls",
      "dockerls",
      "fish_lsp",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "sqlls",
      "taplo",
      "ts_ls",
      "vimls",
      "yamlls",
      "zls",
    },
    automatic_enable = {
      -- We use pyright for python LSP and ruff for python linting/formatting
      -- mason-tool-installer installs ruff for conform.nvim.
      exclude = { "ruff" },
    },
  },
}

return M
