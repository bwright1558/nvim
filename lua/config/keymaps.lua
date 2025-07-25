--------------------------------------------------------------------------------
-- keymaps.lua
--
-- Keymaps to make life a little easier.
--------------------------------------------------------------------------------

-- Disable built-ins that clash with our custom `gr` LSP keys.
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")

local function toggle_quickfix()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0
                        and vim.cmd.cclose or vim.cmd.copen)
  if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
end

local keymaps = {
  ---------------- Window / split navigation & resize ----------------
  { "<C-h>", "<Cmd>SplitLeft<CR>", desc = "Smart Split Left" },
  { "<C-j>", "<Cmd>SplitDown<CR>", desc = "Smart Split Down" },
  { "<C-k>", "<Cmd>SplitUp<CR>", desc = "Smart Split Up" },
  { "<C-l>", "<Cmd>SplitRight<CR>", desc = "Smart Split Right" },

  -- Terminal-mode counterpart (leave <C-...> identical for muscle memory)
  { "<C-h>", [[<C-\><C-n><C-w>h]], desc = "Terminal Window Left", mode = "t" },
  { "<C-j>", [[<C-\><C-n><C-w>j]], desc = "Terminal Window Down", mode = "t" },
  { "<C-k>", [[<C-\><C-n><C-w>k]], desc = "Terminal Window Up", mode = "t" },
  { "<C-l>", [[<C-\><C-n><C-w>l]], desc = "Terminal Window Right", mode = "t" },

  ------------------ Buffer navigation / lifecycle -------------------
  { "]b", "<Cmd>bnext<CR>", desc = "Next Buffer" },
  { "[b", "<Cmd>bprev<CR>", desc = "Prev Buffer" },
  { "<Leader>bj", "<Cmd>bnext<CR>", desc = "Next Buffer" },
  { "<Leader>bk", "<Cmd>bprev<CR>", desc = "Prev Buffer" },
  { "<Leader>bb", function() Snacks.picker.buffers() end, desc = "Buffer List" },
  { "<Leader>bd", "<Cmd>bd<CR>", desc = "Delete Buffer" },

  -------------------- Files & project navigation --------------------
  { "-", "<Cmd>Oil<CR>", desc = "Oil" },
  { "<Leader><Space>", function() Snacks.picker.smart() end, desc = "Smart Finder" },
  { "<Leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
  { "<Leader>fg", function() Snacks.picker.git_files({ cwd = Snacks.git.get_root(vim.uv.cwd()), untracked = true }) end, desc = "Find Git Files (root)" },
  { "<Leader>fG", function() Snacks.picker.git_files({ untracked = true }) end, desc = "Find Git Files (cwd)" },
  { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
  { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  { "<Leader>fn", "<Cmd>enew<CR>", desc = "New File" },

  ------------------------- Search / pickers -------------------------
  { "<Leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
  { "<Leader>ss", function() Snacks.picker.grep({ hidden = true }) end, desc = "Live Grep" },
  { "<Leader>sr", "<Cmd>GrugFar<CR>", desc = "Search & Replace", mode = { "n", "x" } },
  { "<Leader>sg", function() Snacks.picker.git_grep({ cwd = Snacks.git.get_root(vim.uv.cwd()), untracked = true }) end, desc = "Grep Git" },
  { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
  { "<Leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
  { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
  { "<Leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<Leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<Leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
  { "<Leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<Leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights Groups" },
  { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Word / Visual", mode = { "n", "x" } },
  { "<Leader>su", function() Snacks.picker.undo() end, desc = "Undo Tree" },
  { '<Leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
  { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Resume Last Picker" },
  { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix Picker" },
  { "<Leader>sl", function() Snacks.picker.loclist() end, desc = "Location List Picker" },

  ----------------------- Diagnostics / lists ------------------------
  { "]q", "<Cmd>cnext<CR>", desc = "Next Quickfix" },
  { "[q", "<Cmd>cprev<CR>", desc = "Prev Quickfix" },
  { "<Leader>xq", toggle_quickfix, desc = "Toggle Quickfix List" },
  { "<Leader>xl", function()
    local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
                          and vim.cmd.lclose or vim.cmd.lopen)
    if not ok and err then vim.notify(err, vim.log.levels.ERROR) end
  end, desc = "Toggle Location List" },
  { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
  { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
  { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
  { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },

  -------------------- Git (gitsigns + fugitive) ---------------------
  { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next Hunk" },
  { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev Hunk" },
  { "<Leader>gj", function() require("gitsigns").nav_hunk("next") end, desc = "Next Hunk" },
  { "<Leader>gk", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev Hunk" },
  { "<Leader>gg", "<Cmd>G<CR>", desc = "Git (Fugitive)" },
  { "<Leader>g;", "<Cmd>Git push<CR>", desc = "Git Push" },
  { "<Leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
  { "<Leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
  { "<Leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
  { "<Leader>gl", function() require("gitsigns").blame_line() end, desc = "Blame Line" },
  { "<Leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
  { "<Leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<Leader>gc", function() Snacks.picker.git_log() end, desc = "Git Commits" },
  { "<Leader>gC", function() Snacks.picker.git_log({ current_file = true }) end, desc = "Git Commits (file)" },

  -------------------- Terminal toggles / escape ---------------------
  { "<C-/>", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
  { "<C-;>", [[<C-\><C-n>]], desc = "Exit Terminal Mode", mode = "t" },

  ----------------------- Text-editing helpers -----------------------
  { "<", "<gv", desc = "Indent left & keep", mode = "x" },
  { ">", ">gv", desc = "Indent right & keep", mode = "x" },
  { "J", ":m '>+1<CR>gv=gv", desc = "Move Selection Down", mode = "x" },
  { "K", ":m '<-2<CR>gv=gv", desc = "Move Selection Up", mode = "x" },
  { "p", 'p:let @+=@0<CR>:let @"=@0<CR>', desc = "Paste w/o yank", mode = "x" },
  { "P", 'P:let @+=@0<CR>:let @"=@0<CR>', desc = "Paste w/o yank", mode = "x" },

  ---------------------- Word / reference jumps ----------------------
  { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
  { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },

  ------------ Plugin-specific (flash / which-key / misc) ------------
  { "s", function() require("flash").jump() end, desc = "Flash", mode = { "n", "x", "o" } },
  { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter", mode = { "n", "x", "o" } },
  { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
  { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "x", "o" } },
  { "<C-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search", mode = { "c" } },
  { "<Leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },

  ------------------- Mason / Treesitter shortcuts -------------------
  { "<Leader>lI", "<Cmd>Mason<CR>", desc = "Mason" },
  { "<Leader>ti", "<Cmd>TSConfigInfo<CR>", desc = "Treesitter Config Info" },
  { "<Leader>tm", "<Cmd>TSModuleInfo<CR>", desc = "Treesitter Module Info" },

  -------------------------- UI / UX tweaks --------------------------
  { "<Leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

  ------------------------------- Tabs -------------------------------
  { "<Leader><Tab>n", "<Cmd>tabnew<CR>", desc = "New Tab" },
  { "<Leader><Tab>q", "<Cmd>tabclose<CR>", desc = "Close Tab" },
  { "<Leader><Tab>j", "<Cmd>tabnext<CR>", desc = "Next Tab" },
  { "<Leader><Tab>k", "<Cmd>tabprev<CR>", desc = "Prev Tab" },

  ---------------------- Core workflow (Leader) ----------------------
  { "<Leader>w", "<Cmd>w<CR>", desc = "Save" },
  { "<Leader>q", "<Cmd>q<CR>", desc = "Quit" },
  { "<Leader>Q", "<Cmd>qall<CR>", desc = "Quit All" },
  { "<Leader>h", "<Cmd>nohlsearch<CR>", desc = "Clear hlsearch" },
  { "<Leader>/", "gcc", desc = "Toggle Comment", remap = true },
  { "<Leader>/", "gc", desc = "Toggle Comment", mode = "x", remap = true },
  { "<Leader>,", toggle_quickfix, desc = "Toggle Quickfix List" },
  { "<Leader>;", function() Snacks.picker.command_history() end, desc = "Command History" },
  { "<Leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  { "<Leader>p", "<Cmd>Lazy<CR>", desc = "Lazy" },
}

for _, map in ipairs(keymaps) do
  local lhs, rhs, opts = map[1], map[2], { desc = map.desc, silent = true }
  if map.remap then opts.remap = map.remap end
  vim.keymap.set(map.mode or "n", lhs, rhs, opts)
end
