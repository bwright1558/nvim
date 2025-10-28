local M = {
  "ravsii/tree-sitter-d2",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "terrastruct/d2-vim",
  },
  version = "*",
  build = "make nvim-install",
  ft = "d2",
}

return M
