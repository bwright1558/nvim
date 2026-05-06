--- lsp.lua
---
--- Automatically installs, configures, enables, and
--- starts language servers using lspconfig.

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
}, { confirm = false })

require("mason").setup({
  ui = {
    border = "rounded",
  },
})

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
