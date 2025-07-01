-------------------------------------------------------------------------------
-- keymaps.lua
--
-- Keymaps to make life a little easier.
-------------------------------------------------------------------------------

local map = vim.keymap.set

-- All these are remapped to something else.
-- Delete these mappings to remove conflict with new `gr` mapping.
vim.keymap.del("n", "gra")
vim.keymap.del("x", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")

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
map("x", "<", "<gv", { desc = "Indent left and reselect",  silent = true })
map("x", ">", ">gv", { desc = "Indent right and reselect", silent = true })

-------------------------------------------------------------------------------
-- Command-line popup-menu navigation
-------------------------------------------------------------------------------
map("c", "<C-j>", [[pumvisible() ? "<C-n>" : "<C-j>"]], { expr = true, desc = "Next completion item" })
map("c", "<C-k>", [[pumvisible() ? "<C-p>" : "<C-k>"]], { expr = true, desc = "Previous completion item" })

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
map("t", "<C-;>", [[<C-\><C-n>]],       { desc = "Exit terminal mode",    silent = true })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal window left",  silent = true })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal window down",  silent = true })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal window up",    silent = true })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal window right", silent = true })

-------------------------------------------------------------------------------
-- Paste in visual mode WITHOUT yanking replaced text
-------------------------------------------------------------------------------
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without yanking", silent = true })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without yanking", silent = true })

-- Alternative version for paste without yanking.
-- map("x", "p", function()
--   vim.cmd('normal! p')
--   vim.fn.setreg("+", vim.fn.getreg("0"))
--   vim.fn.setreg('"', vim.fn.getreg("0"))
-- end, { desc = "Paste without yanking", silent = true })

-------------------------------------------------------------------------------
-- File navigation
-------------------------------------------------------------------------------
map("n", "-", "<Cmd>Oil<CR>", { desc = "Oil", silent = true })

-------------------------------------------------------------------------------
-- <Leader> mappings
-------------------------------------------------------------------------------

-- Basic operations
map("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit", silent = true })
map("n", "<Leader>Q", "<Cmd>qall<CR>", { desc = "Quit All", silent = true })
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save", silent = true })
map("n", "<Leader>h", "<Cmd>nohlsearch<CR>", { desc = "Clear Search Highlight", silent = true })
map("n", "<Leader>:", function() Snacks.picker.command_history() end, { desc = "Command History", silent = true })
map("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "File Explorer", silent = true })
map("n", "<Leader>p", "<Cmd>Lazy<CR>", { desc = "Lazy Plugin Manager", silent = true })

-- Quickfix
map("n", "<Leader>,", function()
  local is_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end
  vim.cmd(is_open and "cclose" or "copen")
end, { desc = "Toggle Quickfix", silent = true })

-- File operations
map("n", "<Leader>ff", function() Snacks.picker.files({ hidden = true }) end, { desc = "Find Files", silent = true })
map("n", "<Leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files", silent = true })
map("n", "<Leader>fn", "<Cmd>enew<CR>", { desc = "New File", silent = true })
map("n", "<Leader>fe", "<Cmd>Neotree toggle<CR>", { desc = "File Explorer", silent = true })

-- Comments
map("n", "<Leader>/", "gcc", { desc = "Toggle Comment Line", silent = true, remap = true })
map("x", "<Leader>/", "gc", { desc = "Toggle Comment Block", silent = true, remap = true })

-- Buffer navigation
map("n", "<Leader>bd", "<Cmd>bd<CR>", { desc = "Delete Buffer", silent = true })
map("n", "<Leader>bj", "<Cmd>bn<CR>", { desc = "Next Buffer", silent = true })
map("n", "<Leader>bk", "<Cmd>bp<CR>", { desc = "Prev Buffer", silent = true })
map("n", "<Leader>bl", "<Cmd>b#<CR>", { desc = "Last Buffer", silent = true })
map("n", "<Leader>bb", function() Snacks.picker.buffers() end, { desc = "Buffer List", silent = true })

-- Git: Fugitive
map("n", "<Leader>gg", "<Cmd>G<CR>", { desc = "Git Status (Fugitive)", silent = true })
map("n", "<Leader>g;", "<Cmd>Git push<CR>", { desc = "Git Push", silent = true })

-- Git: Gitsigns
map("n", "<Leader>gj", function() require("gitsigns").nav_hunk("next") end, { desc = "Next Hunk", silent = true })
map("n", "<Leader>gk", function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev Hunk", silent = true })
map("n", "<Leader>gl", function() require("gitsigns").blame_line() end, { desc = "Blame Line", silent = true })
map("n", "<Leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk", silent = true })
map("n", "<Leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk", silent = true })
map("n", "<Leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer", silent = true })
map("n", "<Leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage/Unstage Hunk", silent = true })

-- Git: Snacks.picker
map("n", "<Leader>go", function() Snacks.picker.git_status() end, { desc = "Git Status (Snacks.picker)", silent = true })
map("n", "<Leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches", silent = true })
map("n", "<Leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Commits", silent = true })
map("n", "<Leader>gC", function() Snacks.picker.git_log({ current_file = true }) end, { desc = "File Commits", silent = true })

-- Search
map("n", "<Leader>sf", function() Snacks.picker.files({ hidden = true }) end, { desc = "Find Files", silent = true })
map("n", "<Leader>sg", function() Snacks.picker.git_files({ cwd = Snacks.git.get_root(vim.uv.cwd()) }) end, { desc = "Find Files (Git-aware)", silent = true })
map("n", "<Leader>st", function() Snacks.picker.grep() end, { desc = "Search Text (Grep)", silent = true })
map("n", "<Leader>sb", function() Snacks.picker.buffers() end, { desc = "Open Buffers", silent = true })
map("n", "<Leader>sh", function() Snacks.picker.help() end, { desc = "Help Tags", silent = true })
map("n", "<Leader>sr", function() Snacks.picker.recent() end, { desc = "Recent Files", silent = true })
map("n", "<Leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix", silent = true })
map("n", "<Leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps", silent = true })
map("n", "<Leader>sm", function() Snacks.picker.marks() end, { desc = "Marks", silent = true })
map("n", "<Leader>ss", function() Snacks.picker.grep_word() end, { desc = "Search Word", silent = true })
map("x", "<Leader>ss", function() Snacks.picker.grep_word() end, { desc = "Search Visual Selection", silent = true })
map("n", "<Leader>sR", function() Snacks.picker.registers() end, { desc = "Registers", silent = true })
map("n", "<Leader>sc", function() Snacks.picker.commands() end, { desc = "Commands", silent = true })
map("n", "<Leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages", silent = true })
map("n", "<Leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlight Groups", silent = true })
map("n", "<Leader>sC", function() Snacks.picker.colorschemes({ preview = "none" }) end, { desc = "Colorschemes", silent = true })
map("n", "<Leader>sp", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes (Preview)", silent = true })

-- Treesitter
map("n", "<Leader>ti", "<Cmd>TSConfigInfo<CR>", { desc = "Treesitter Info", silent = true })
map("n", "<Leader>tm", "<Cmd>TSModuleInfo<CR>", { desc = "Treesitter Modules", silent = true })

-- Mason
map("n", "<Leader>lI", "<Cmd>Mason<CR>", { desc = "Mason", silent = true })
