-- Set <Space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Disable unused language providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Short message options
vim.opt.shortmess:append({ I = true, c = true })

-- General options
vim.o.confirm = true
vim.o.modeline = false
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.virtualedit = "block"

-- Tab / indentation options
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Line wrap options
-- Disabled by default. Wrapping is enabled for specific file types
vim.o.wrap = false
vim.o.breakindent = true
vim.o.linebreak = true

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.grepprg = "rg --vimgrep"
vim.opt.path:append("**") -- include subdirectories in file search

-- Popup menu / command window / completion options
vim.o.pumheight = 10
vim.o.cmdwinheight = 10
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- Window split options
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

-- Undo history options
vim.o.undofile = true

-- Timer options
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Scroll options
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- UI options
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
