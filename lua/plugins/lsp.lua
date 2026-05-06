--- lsp.lua
---
--- Automatically installs, configures, enables, and
--- starts language servers using lspconfig.

vim.pack.add({
  -- Depends on mason.nvim
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
}, { confirm = false })

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "fish_lsp",
    "golangci_lint_ls",
    "gopls",
    "graphql",
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
})
