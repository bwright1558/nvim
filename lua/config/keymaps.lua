-------------------------------------------------------------------------------
-- keymaps.lua
--
-- Keymaps to make life a little easier.
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
map("t", "<C-,>", [[<C-\><C-n>]],       { desc = "Exit terminal mode",    silent = true })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Terminal window left",  silent = true })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Terminal window down",  silent = true })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Terminal window up",    silent = true })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Terminal window right", silent = true })

-------------------------------------------------------------------------------
-- Paste in visual mode WITHOUT yanking replaced text
-------------------------------------------------------------------------------
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without yanking", silent = true })
map("x", "P", 'P:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without yanking", silent = true })

-------------------------------------------------------------------------------
-- <Leader> mappings
-------------------------------------------------------------------------------

-- Toggle Quickfix window
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

-- Basic operations
map("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit", silent = true })
map("n", "<Leader>Q", "<Cmd>qall<CR>", { desc = "Quit All", silent = true })
map("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Save", silent = true })
map("n", "<Leader>h", "<Cmd>nohlsearch<CR>", { desc = "Clear Search Highlight", silent = true })
map("n", "<Leader>:", "<Cmd>Telescope command_history<CR>", { desc = "Command History", silent = true })

-- Comments
map("n", "<Leader>/", "gcc", { desc = "Toggle Comment Line", silent = true, remap = true })
map("x", "<Leader>/", "gc", { desc = "Toggle Comment Block", silent = true, remap = true })

-- Buffer navigation
map("n", "<Leader>bd", "<Cmd>bd<CR>", { desc = "Delete Buffer", silent = true })
map("n", "<Leader>bj", "<Cmd>bj<CR>", { desc = "Next Buffer", silent = true })
map("n", "<Leader>bk", "<Cmd>bp<CR>", { desc = "Prev Buffer", silent = true })
map("n", "<Leader>bl", "<Cmd>b#<CR>", { desc = "Last Buffer", silent = true })
map("n", "<Leader>bb", "<Cmd>Telescope buffers<CR>", { desc = "Buffer List", silent = true })

-- Quickfix
map("n", "<Leader>sq", "<Cmd>Telescope quickfix<CR>", { desc = "Quickfix List", silent = true })

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

-- Git: Telescope
map("n", "<Leader>go", "<Cmd>Telescope git_status<CR>", { desc = "Git Status (Telescope)", silent = true })
map("n", "<Leader>gb", "<Cmd>Telescope git_branches<CR>", { desc = "Git Branches", silent = true })
map("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", { desc = "Git Commits", silent = true })
map("n", "<Leader>gC", "<Cmd>Telescope git_bcommits<CR>", { desc = "File Commits", silent = true })

-- Search
map("n", "<Leader>sf", "<Cmd>Telescope find_files<CR>", { desc = "Find Files", silent = true })
map("n", "<Leader>sg", "<Cmd>Telescope live_grep<CR>", { desc = "Search Text (Grep)", silent = true })
map("n", "<Leader>sb", "<Cmd>Telescope buffers<CR>", { desc = "Open Buffers", silent = true })
map("n", "<Leader>sh", "<Cmd>Telescope help_tags<CR>", { desc = "Help Tags", silent = true })
map("n", "<Leader>sr", "<Cmd>Telescope oldfiles<CR>", { desc = "Recent Files", silent = true })
map("n", "<Leader>sq", "<Cmd>Telescope quickfix<CR>", { desc = "Quickfix", silent = true })
map("n", "<Leader>sk", "<Cmd>Telescope keymaps<CR>", { desc = "Keymaps", silent = true })
map("n", "<Leader>sm", "<Cmd>Telescope marks<CR>", { desc = "Marks", silent = true })
map("n", "<Leader>ss", "<Cmd>Telescope grep_string<CR>", { desc = "Search Word Under Cursor", silent = true })
map("x", "<Leader>ss", "<Cmd>Telescope grep_string<CR>", { desc = "Search Word Under Cursor", silent = true })
map("n", "<Leader>sR", "<Cmd>Telescope registers<CR>", { desc = "Registers", silent = true })
map("n", "<Leader>sc", "<Cmd>Telescope commands<CR>", { desc = "Commands", silent = true })
map("n", "<Leader>sM", "<Cmd>Telescope man_pages<CR>", { desc = "Man Pages", silent = true })
map("n", "<Leader>sH", "<Cmd>Telescope highlights<CR>", { desc = "Highlight Groups", silent = true })
map("n", "<Leader>sC", "<Cmd>Telescope colorscheme<CR>", { desc = "Colorschemes", silent = true })
map("n", "<Leader>sp", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Colorschemes (Preview)", silent = true })
