vim.pack.add({
  -- Depends on mason.nvim
  "https://github.com/neovim/nvim-lspconfig",
}, { confirm = false })

vim.lsp.enable({
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
})
