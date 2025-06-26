local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    {
      "mason-org/mason.nvim",
      -- build = ":MasonUpdate",
      opts = {
        ui = {
          border = "rounded",
        },
      },
    },
  },
  opts = {
    ensure_installed = {
      "bashls",
      "cssls",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "ts_ls",
      "vimls",
    },
  },
}

return M
