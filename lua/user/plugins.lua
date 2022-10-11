local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins file
local packer_group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = packer_group,
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

local border = require("user.borders").style

local packer = require("packer")

return packer.startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- Themes
    use "EdenEast/nightfox.nvim"

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function() require("user.configs.treesitter") end,
      run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }
    use {
      "numToStr/Comment.nvim",
      config = function() require("user.configs.comment") end,
      event = "BufRead",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Autopairs
    use {
      "windwp/nvim-autopairs",
      config = function() require("user.configs.autopairs") end,
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      config = function() require("user.configs.telescope") end,
    }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }
    use {
      "ahmedkhalf/project.nvim",
      config = function() require("user.configs.project") end,
    }

    -- Which Key
    use {
      "folke/which-key.nvim",
      config = function() require("user.configs.which-key") end,
      event = "BufWinEnter",
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      config = function() require("user.configs.cmp") end,
    }
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "saadparwaiz1/cmp_luasnip"

    -- Snippets
    use "L3MON4D3/LuaSnip" -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use {
      "williamboman/mason.nvim",
      config = function() require("user.configs.mason") end,
    }
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "folke/lua-dev.nvim"
    use "tamago324/nlsp-settings.nvim"
    use {
      "RRethy/vim-illuminate",
      config = function() require("user.configs.illuminate") end,
    }
    use {
      "ray-x/lsp_signature.nvim",
      config = function() require("user.configs.lsp-signature") end,
    }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      config = function() require("user.configs.toggleterm") end,
    }

    -- UI
    use {
      "nvim-lualine/lualine.nvim",
      config = function() require("user.configs.lualine") end,
    }
    use {
      "lewis6991/gitsigns.nvim",
      config = function() require("user.configs.gitsigns") end,
      event = "BufRead"
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function() require("user.configs.indentline") end,
    }
    use {
      "kyazdani42/nvim-tree.lua",
      config = function() require("user.configs.nvim-tree") end,
    }
    use {
      "anuvyklack/pretty-fold.nvim",
      config = function() require("user.configs.pretty-fold") end,
      event = "BufRead",
    }

    -- General
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "junegunn/vim-easy-align"

    -- Navigation
    use {
      "ggandor/leap.nvim",
      config = function() require("user.configs.leap") end,
    }
    use "sindrets/winshift.nvim"
    use {
      "beauwilliams/focus.nvim",
      config = function() require("user.configs.focus") end,
    }
    use {
      "kevinhwang91/nvim-bqf",
      config = function() require("user.configs.bqf") end,
      ft = "qf",
    }
    use {
      "junegunn/fzf",
      run = function() vim.fn["fzf#install"]() end,
    }

    -- Git
    use {
      "tpope/vim-fugitive",
      cmd = { "G", "Git" },
      ft = "fugitive",
    }
    use "sindrets/diffview.nvim"

    -- Language specific
    use {
      "ray-x/go.nvim",
      config = function() require("user.configs.go") end,
      ft = "go",
    }
    use {
      "Vimjas/vim-python-pep8-indent",
      ft = "python",
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
      packer.sync()
    end
  end,

  config = {
    display = {
      prompt_border = border,
      open_fn = function()
        return require("packer.util").float({ border = border })
      end,
    },
  },
})
