local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local border = require("user.borders").style
local opts = {
  ui = {
    border = border,
  },
}

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "kyazdani42/nvim-web-devicons",

  -- Themes
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function() require("user.configs.nightfox") end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function() require("user.configs.treesitter") end,
    build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("user.configs.comment") end,
    event = "BufRead",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function() require("user.configs.autopairs") end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function() require("user.configs.telescope") end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Which Key
  {
    "folke/which-key.nvim",
    config = function() require("user.configs.which-key") end,
    event = "BufWinEnter",
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = function() require("user.configs.cmp") end,
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-buffer",

  -- Snippets
  "L3MON4D3/LuaSnip", -- snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  {
    "williamboman/mason.nvim",
    config = function() require("user.configs.mason") end,
  },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "folke/neodev.nvim",
  "tamago324/nlsp-settings.nvim",
  {
    "RRethy/vim-illuminate",
    config = function() require("user.configs.illuminate") end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function() require("user.configs.lsp-signature") end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function() require("user.configs.toggleterm") end,
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("user.configs.lualine") end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("user.configs.gitsigns") end,
    event = "BufRead"
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("user.configs.indentline") end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function() require("user.configs.nvim-tree") end,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    config = function() require("user.configs.pretty-fold") end,
    event = "BufRead",
  },

  -- General
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "junegunn/vim-easy-align",

  -- Navigation
  "sindrets/winshift.nvim",
  {
    "beauwilliams/focus.nvim",
    config = function() require("user.configs.focus") end,
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function() require("user.configs.bqf") end,
    ft = "qf",
  },
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end }, -- optional dependency for nvim-bqf

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    ft = "fugitive",
  },
  "sindrets/diffview.nvim",

  -- Language specific
  {
    "ray-x/go.nvim",
    config = function() require("user.configs.go") end,
    ft = "go",
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
}, opts)
