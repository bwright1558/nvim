local M = {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "kyazdani42/nvim-web-devicons",

  -- LSP
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "folke/neodev.nvim",
  "tamago324/nlsp-settings.nvim",

  -- General
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "junegunn/vim-easy-align",

  -- Navigation
  "sindrets/winshift.nvim",

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    ft = "fugitive",
  },
  "sindrets/diffview.nvim",

  -- Language specific
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
}

return M
