-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

local keymap = vim.keymap.set
local opts = { silent = true }

keymap("n", "<C-h>", "<Cmd>FocusSplitLeft<CR>", opts)
keymap("n", "<C-j>", "<Cmd>FocusSplitDown<CR>", opts)
keymap("n", "<C-k>", "<Cmd>FocusSplitUp<CR>", opts)
keymap("n", "<C-l>", "<Cmd>FocusSplitRight<CR>", opts)
keymap("n", "mm", "<Cmd>WinShift<CR>", opts)
keymap("n", "mx", "<Cmd>WinShift swap<CR>", opts)
keymap("n", "ga", "<Plug>(EasyAlign)", opts)
keymap("x", "ga", "<Plug>(EasyAlign)", opts)

-- Special mappings to adjust indentation when moving blocks of code up and down lines.
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)
