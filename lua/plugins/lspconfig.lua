-- lspconfig.lua
--
-- Automatically installs, configures, enables, and
-- starts language servers.
--
-- See: https://github.com/mason-org/mason-lspconfig.nvim
--      https://github.com/mason-org/mason.nvim
--      https://github.com/neovim/nvim-lspconfig

local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
  },
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
      "ts_ls",
      "vimls",
      "zls",
    },
  },
}

return M
