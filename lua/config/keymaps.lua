-------------------------------------------------------------------------------
-- keymaps.lua
--
-- Keymaps that rely **only on core Neovim**.
-- (Plugin-specific maps live alongside their respective plugin configs.)
--
-- Conventions
-- -----------
-- * <Leader>-prefixed maps will be defined in which-key plugin.
-- * Non-leader maps live here.
-------------------------------------------------------------------------------

local map = vim.keymap.set

-------------------------------------------------------------------------------
-- Window navigation (uses your smart_split commands)
-------------------------------------------------------------------------------
map("n", "<C-h>", "<Cmd>SplitLeft<CR>",  { desc = "Smart split left",  silent = true })
map("n", "<C-j>", "<Cmd>SplitDown<CR>",  { desc = "Smart split down",  silent = true })
map("n", "<C-k>", "<Cmd>SplitUp<CR>",    { desc = "Smart split up",    silent = true })
map("n", "<C-l>", "<Cmd>SplitRight<CR>", { desc = "Smart split right", silent = true })

-------------------------------------------------------------------------------
-- Indenting helpers (keep visual selection)
-------------------------------------------------------------------------------
map("v", "<", "<gv", { desc = "Indent left and reselect",  silent = true })
map("v", ">", ">gv", { desc = "Indent right and reselect", silent = true })

-------------------------------------------------------------------------------
-- Command-line popup-menu navigation
-------------------------------------------------------------------------------
map("c", "<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true, desc = "Next completion item" })
map("c", "<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true, desc = "Previous completion item" })

-------------------------------------------------------------------------------
-- Quickfix navigation
-------------------------------------------------------------------------------
map("n", "]q", "<Cmd>cnext<CR>", { desc = "Next quickfix item",     silent = true })
map("n", "[q", "<Cmd>cprev<CR>", { desc = "Previous quickfix item", silent = true })

-------------------------------------------------------------------------------
-- Move selected lines up / down
-------------------------------------------------------------------------------
map("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up",   silent = true })

-------------------------------------------------------------------------------
-- Terminal-mode mappings
-------------------------------------------------------------------------------
map("t", "<C-,>", [[<C-\><C-n>]],       { desc = "Exit terminal mode",    silent = true })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal window left",  silent = true })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal window down",  silent = true })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal window up",    silent = true })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal window right", silent = true })

-------------------------------------------------------------------------------
-- Paste in visual mode WITHOUT yanking replaced text
-------------------------------------------------------------------------------
map("x", "p", '"_dP', { desc = "Preserve register (paste)", silent = true })
map("x", "P", '"_dP', { desc = "Preserve register (Paste)", silent = true })
