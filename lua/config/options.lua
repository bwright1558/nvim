-- Leader configuration --------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Disable unused language providers ------------------------------------------
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Short message tweaks --------------------------------------------------------
vim.opt.shortmess:append("c") -- suppress ins‑completion “match xx of yy”
vim.opt.shortmess:append("I") -- skip the intro splash

-- General editing behaviour ---------------------------------------------------
vim.opt.confirm = true
vim.opt.modeline = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- Search ----------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Completion / popup menu -----------------------------------------------------
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.pumheight = 10
vim.opt.updatetime = 250

-- Window management -----------------------------------------------------------
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Interface / UI --------------------------------------------------------------
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.showtabline = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.timeoutlen = 500
vim.opt.virtualedit = "block"
-- vim.opt.winborder = "rounded" -- commented out b/c Lazy and Telescope has weird UI

-- Indentation -----------------------------------------------------------------
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 2
vim.opt.tabstop     = 2
vim.opt.smartindent = true

-- File handling ---------------------------------------------------------------
vim.opt.swapfile = false
vim.opt.undofile = true
