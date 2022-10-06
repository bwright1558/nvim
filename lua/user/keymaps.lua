-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
