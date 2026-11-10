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
  "jdtls",
  "jsonls",
  "lua_ls",
  "pyright",
  "roslyn_ls",
  "rust_analyzer",
  "sourcekit",
  -- "sqlls",
  "taplo",
  "ts_ls",
  "vimls",
  "yamlls",
  "zls",
})
