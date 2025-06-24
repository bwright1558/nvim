-- Remap space as leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Disable optional vim.provider (silence warnings in :checkhealth).
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message

vim.opt.modeline = false                        -- sets options for a particular file using modelines
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a"       -- allow the mouse to be used in neovim
vim.opt.pumheight = 10    -- pop up menu height
vim.opt.showmode = false  -- we don't need to see things like -- INSERT -- anymore
