local cache_dir = vim.fn.stdpath("cache")

-- Remap space as leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
-- vim.opt.whichwrap:append("<,>,[,],h,l")

vim.opt.sessionoptions:remove({ "tabpages" }) -- tab-scoped sessions.

vim.opt.modeline = false                      -- sets options for a particular file using modelines
vim.opt.backup = false                        -- creates a backup file
vim.opt.clipboard = "unnamedplus"             -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                         -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                      -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                -- the encoding written to a file

-- XXX: Folding causes performance issues on large files.
-- vim.opt.foldmethod = "expr" -- folding, set to "expr" for treesitter based folding
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- vim.opt.foldenable = true -- allows code folding
-- vim.opt.foldlevel = 99 -- zero closes all folds, higher numbers close fewer folds

vim.opt.hidden = true                  -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                -- highlight all matches on previous search pattern
vim.opt.ignorecase = true              -- ignore case in search patterns
vim.opt.mouse = "a"                    -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                 -- pop up menu height
vim.opt.showmode = false               -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                -- don't show tabs
vim.opt.smartcase = true               -- smart case
vim.opt.smartindent = true             -- make indenting smarter again
vim.opt.splitbelow = true              -- force all horizontal splits to go below current window
vim.opt.splitright = true              -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false               -- creates a swapfile
vim.opt.termguicolors = true           -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500               -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                   -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = cache_dir .. "/undo" -- set an undo directory
vim.opt.undofile = true                -- enable persistent undo
vim.opt.updatetime = 100               -- faster completion (in milliseconds)
vim.opt.writebackup = false            -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true               -- convert tabs to spaces
vim.opt.shiftwidth = 2                 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                    -- insert 2 spaces for a tab
vim.opt.cursorline = true              -- highlight the current line
vim.opt.number = true                  -- set numbered lines
vim.opt.relativenumber = true          -- set relative numbered lines
vim.opt.numberwidth = 4                -- set width of number column
vim.opt.signcolumn = "yes"             -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                   -- display lines as one long line
vim.opt.shadafile = cache_dir .. "/nvim.shada"
vim.opt.scrolloff = 8                  -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8              -- minimal number of screen lines to keep left and right of the cursor
vim.opt.showcmd = false                -- Don't show key presses in status line
vim.opt.ruler = false                  -- Don't show ruler
-- vim.opt.laststatus = 3 -- lualine sets this automatically based on globalstatus option
