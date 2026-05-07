--- keymaps.lua
---
--- Keymaps to make life a little easier.

-- Disable built-ins that clash with our custom `gr` LSP keys.
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")

local function toggle_quickfix()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not ok and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

local function lazy_require(modname)
  local mod

  return function()
    if not mod then
      mod = require(modname)
    end
    return mod
  end
end

local gitsigns = lazy_require("gitsigns")
local whichkey = lazy_require("which-key")
local ts_select = lazy_require("nvim-treesitter-textobjects.select")
local ts_move = lazy_require("nvim-treesitter-textobjects.move")
local ts_swap = lazy_require("nvim-treesitter-textobjects.swap")

-- stylua: ignore start
local keymap_specs = {
  -- Window / split navigation & resize
  { "<C-h>", "<Cmd>SplitLeft<CR>", desc = "Move/split left" },
  { "<C-j>", "<Cmd>SplitDown<CR>", desc = "Move/split down" },
  { "<C-k>", "<Cmd>SplitUp<CR>", desc = "Move/split up" },
  { "<C-l>", "<Cmd>SplitRight<CR>", desc = "Move/split right" },

  -- Terminal-mode counterpart (leave <C-...> identical for muscle memory)
  { "<C-h>", [[<C-\><C-n><C-w>h]], desc = "Terminal window left", mode = "t" },
  { "<C-j>", [[<C-\><C-n><C-w>j]], desc = "Terminal window down", mode = "t" },
  { "<C-k>", [[<C-\><C-n><C-w>k]], desc = "Terminal window up", mode = "t" },
  { "<C-l>", [[<C-\><C-n><C-w>l]], desc = "Terminal window right", mode = "t" },

  -- Buffer navigation / lifecycle
  { "]b", "<Cmd>bnext<CR>", desc = "Next buffer" },
  { "[b", "<Cmd>bprev<CR>", desc = "Previous buffer" },
  { "<Leader>bj", "<Cmd>bnext<CR>", desc = "Next buffer" },
  { "<Leader>bk", "<Cmd>bprev<CR>", desc = "Previous buffer" },
  { "<Leader>bb", function() Snacks.picker.buffers() end, desc = "Buffer list" },
  { "<Leader>bd", "<Cmd>bd<CR>", desc = "Delete buffer" },

  -- Files & project navigation
  { "-", "<Cmd>Oil<CR>", desc = "Oil" },
  { "<Leader><Space>", function() Snacks.picker.smart() end, desc = "Smart finder" },
  { "<Leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find files" },
  { "<Leader>fg", function() Snacks.picker.git_files({ cwd = Snacks.git.get_root(vim.uv.cwd()), untracked = true }) end, desc = "Find git files (root)" },
  { "<Leader>fG", function() Snacks.picker.git_files({ untracked = true }) end, desc = "Find git files (cwd)" },
  { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
  { "<Leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  { "<Leader>fn", "<Cmd>enew<CR>", desc = "New file" },

  -- Search / pickers
  { "<Leader>s/", function() Snacks.picker.search_history() end, desc = "Search history" },
  { "<Leader>ss", function() Snacks.picker.grep({ hidden = true }) end, desc = "Live grep" },
  { "<Leader>sr", "<Cmd>GrugFar<CR>", desc = "Search & replace", mode = { "n", "x" } },
  { "<Leader>sg", function() Snacks.picker.git_grep({ cwd = Snacks.git.get_root(vim.uv.cwd()), untracked = true }) end, desc = "Grep git" },
  { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer lines" },
  { "<Leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
  { "<Leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
  { "<Leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
  { "<Leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<Leader>sM", function() Snacks.picker.man() end, desc = "Man pages" },
  { "<Leader>sh", function() Snacks.picker.help() end, desc = "Help pages" },
  { "<Leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights groups" },
  { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Word / visual", mode = { "n", "x" } },
  { "<Leader>su", function() Snacks.picker.undo() end, desc = "Undo tree" },
  { '<Leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
  { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
  { "<Leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix picker" },
  { "<Leader>sl", function() Snacks.picker.loclist() end, desc = "Location list picker" },

  -- Quickfix
  { "<Leader>qq", toggle_quickfix, desc = "Toggle quickfix list" },
  { "<Leader>qj", "<Cmd>cnext<CR>", desc = "Next quickfix" },
  { "<Leader>qk", "<Cmd>cprev<CR>", desc = "Previous quickfix" },
  { "]q", "<Cmd>cnext<CR>", desc = "Next quickfix" },
  { "[q", "<Cmd>cprev<CR>", desc = "Previous quickfix" },
  {
    "<Leader>ql",
    function()
      local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
      if not ok and err then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end,
    desc = "Toggle location list",
  },

  -- Git (gitsigns + fugitive)
  { "]h", function() gitsigns().nav_hunk("next") end, desc = "Next hunk" },
  { "[h", function() gitsigns().nav_hunk("prev") end, desc = "Previous hunk" },
  { "<Leader>gj", function() gitsigns().nav_hunk("next") end, desc = "Next hunk" },
  { "<Leader>gk", function() gitsigns().nav_hunk("prev") end, desc = "Previous hunk" },
  { "<Leader>gg", "<Cmd>G<CR>", desc = "Git (Fugitive)" },
  { "<Leader>g;", "<Cmd>Git push<CR>", desc = "Git push" },
  { "<Leader>gs", function() gitsigns().stage_hunk() end, desc = "Stage hunk" },
  { "<Leader>gr", function() gitsigns().reset_hunk() end, desc = "Reset hunk" },
  { "<Leader>gR", function() gitsigns().reset_buffer() end, desc = "Reset buffer" },
  { "<Leader>gl", function() gitsigns().blame_line() end, desc = "Blame line" },
  { "<Leader>gp", function() gitsigns().preview_hunk() end, desc = "Preview hunk" },
  { "<Leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
  { "<Leader>gc", function() Snacks.picker.git_log() end, desc = "Git commits" },
  { "<Leader>gC", function() Snacks.picker.git_log({ current_file = true }) end, desc = "Git commits (file)" },

  -- Terminal toggles / escape
  { "<C-/>", function() Snacks.terminal() end, desc = "Toggle terminal", mode = { "n", "t" } },
  { "<C-;>", [[<C-\><C-n>]], desc = "Exit terminal mode", mode = "t" },

  -- Text-editing helpers
  { "<", "<gv", desc = "Indent left & keep", mode = "x" },
  { ">", ">gv", desc = "Indent right & keep", mode = "x" },
  { "J", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "x" },
  { "K", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "x" },
  { "p", 'p:let @+=@0<CR>:let @"=@0<CR>', desc = "Paste w/o yank", mode = "x" },
  { "P", 'P:let @+=@0<CR>:let @"=@0<CR>', desc = "Paste w/o yank", mode = "x" },

  -- Word / reference jumps
  { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
  { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" },

  -- Which-Key
  { "<Leader>?", function() whichkey().show({ global = false }) end, desc = "Buffer local keymaps (which-key)" },

  -- EasyAlign
  { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign" },
  { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign", mode = "x" },

  -- Treesitter Textobjects
  -- select
  { "af", function() ts_select().select_textobject("@function.outer", "textobjects") end, desc = "Select outer part of a function region", mode = { "x", "o" } },
  { "if", function() ts_select().select_textobject("@function.inner", "textobjects") end, desc = "Select inner part of a function region", mode = { "x", "o" } },
  { "ac", function() ts_select().select_textobject("@class.outer", "textobjects") end, desc = "Select outer part of a class region", mode = { "x", "o" } },
  { "ic", function() ts_select().select_textobject("@class.inner", "textobjects") end, desc = "Select inner part of a class region", mode = { "x", "o" } },
  { "aa", function() ts_select().select_textobject("@parameter.outer", "textobjects") end, desc = "Select outer part of a parameter region", mode = { "x", "o" } },
  { "ia", function() ts_select().select_textobject("@parameter.inner", "textobjects") end, desc = "Select inner part of a parameter region", mode = { "x", "o" } },
  { "as", function() ts_select().select_textobject("@local.scope", "locals") end, desc = "Select language scope", mode = { "x", "o" } },

  -- move
  { "]m", function() ts_move().goto_next_start("@function.outer", "textobjects") end, desc = "Next function start", mode = { "n", "x", "o" } },
  { "]c", function() ts_move().goto_next_start("@class.outer", "textobjects") end, desc = "Next class start", mode = { "n", "x", "o" } },
  { "[m", function() ts_move().goto_previous_start("@function.outer", "textobjects") end, desc = "Previous function start", mode = { "n", "x", "o" } },
  { "[c", function() ts_move().goto_previous_start("@class.outer", "textobjects") end, desc = "Previous class start", mode = { "n", "x", "o" } },

  -- swap
  { "<Leader>a", function() ts_swap().swap_next("@parameter.inner", "textobjects") end, desc = "Swap next parameter" },
  { "<Leader>A", function() ts_swap().swap_previous("@parameter.inner", "textobjects") end, desc = "Swap previous parameter" },

  -- Mason / Treesitter shortcuts
  { "<Leader>lI", "<Cmd>Mason<CR>", desc = "Mason" },
  { "<Leader>ti", "<Cmd>checkhealth nvim-treesitter<CR>", desc = "Treesitter health" },
  { "<Leader>tm", "<Cmd>TSLog<CR>", desc = "Treesitter log" },

  -- UI / UX tweaks
  { "<Leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

  -- Tabs
  { "<Leader><Tab>n", "<Cmd>tabnew<CR>", desc = "New tab" },
  { "<Leader><Tab>q", "<Cmd>tabclose<CR>", desc = "Close tab" },
  { "<Leader><Tab>j", "<Cmd>tabnext<CR>", desc = "Next tab" },
  { "<Leader><Tab>k", "<Cmd>tabprev<CR>", desc = "Previous tab" },

  -- Windows
  { "<Leader>wo", "<C-w>o", desc = "Close all other windows" },
  { "<Leader>wh", "<C-w>h", desc = "Go to the left window" },
  { "<Leader>wj", "<C-w>j", desc = "Go to the down window" },
  { "<Leader>wk", "<C-w>k", desc = "Go to the up window" },
  { "<Leader>wl", "<C-w>l", desc = "Go to the right window" },
  { "<Leader>wr", "<C-w>r", desc = "Rotate windows" },
  { "<Leader>wR", "<C-w>R", desc = "Reverse rotate windows" },

  -- Core workflow (Leader)
  { "<Leader>h", "<Cmd>nohlsearch<CR>", desc = "Clear search highlight" },
  { "<Leader>/", "gcc", desc = "Toggle comment", remap = true },
  { "<Leader>/", "gc", desc = "Toggle comment", mode = "x", remap = true },
  { "<Leader>;", function() Snacks.picker.command_history() end, desc = "Command history" },
  { "<Leader>e", function() Snacks.explorer() end, desc = "File explorer" },
  { "<Leader>p", "<Cmd>PackUpdate<CR>", desc = "Update plugins" },
  {
    "<Esc>",
    function()
      if vim.v.hlsearch == 1 then
        vim.cmd.nohlsearch()
        return ""
      else
        return "<Esc>"
      end
    end,
    expr = true,
  }
}
-- stylua: ignore end

local keymaps = require("utils.keymaps")
keymaps.register(keymap_specs)
