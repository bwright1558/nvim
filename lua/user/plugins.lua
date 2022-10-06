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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

return packer.startup({
  function(use)
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- General
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function() require("user.configs.treesitter") end,
      run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }
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

    -- Themes
    use "EdenEast/nightfox.nvim"

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

    -- Language specific plugins
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
      prompt_border = "rounded",
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})
