local ok, whichkey = pcall(require, "which-key")
if not ok then
  return
end

-- Smartly opens either git_files or find_files, depending on whether the
-- working directory is contained in a Git repo.
local find_project_files = function()
  local git_files_ok = pcall(vim.cmd, "Telescope git_files")

  if not git_files_ok then
    vim.cmd("Telescope find_files")
  end
end

-- Toggle quickfix window.
local toggle_quickfix = function()
  local fn = vim.fn
  if #fn.filter(fn.getwininfo(), "v:val.quickfix") == 0 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

local opts = {
  mode = "n",
  prefix = "<Leader>",
}

local vopts = {
  mode = "v",
  prefix = "<Leader>",
}

local mappings = {
  [";"] = { "<Cmd>Telescope filetypes<CR>", "Filetypes" },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  [","] = { toggle_quickfix, "QuickFix" },
  q = { "<Cmd>q<CR>", "Quit" },
  w = { "<Cmd>w<CR>", "Save" },
  c = { "<Cmd>bd<CR>", "Close Buffer" },
  f = { find_project_files, "Find File" },
  h = { "<Cmd>nohlsearch<CR>", "No Highlight" },
  e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
  P = { "<Cmd>Telescope projects<CR>", "Projects" },
  b = {
    name = "Buffers",
    f = { "<Cmd>Telescope buffers<CR>", "Find" },
    j = { "<Cmd>bn<CR>", "Next" },
    k = { "<Cmd>bp<CR>", "Previous" },
  },
  p = {
    name = "Packer",
    c = { "<Cmd>PackerCompile<CR>", "Compile" },
    i = { "<Cmd>PackerInstall<CR>", "Install" },
    s = { "<Cmd>PackerSync<CR>", "Sync" },
    S = { "<Cmd>PackerStatus<CR>", "Status" },
    u = { "<Cmd>PackerUpdate<CR>", "Update" },
  },
  g = {
    name = "Git",
    [";"] = { ":Git ", "Git Command", silent = false },
    g = { "<Cmd>G<CR>", "Git Status" },
    j = { function() require "gitsigns".next_hunk() end, "Next Hunk" },
    k = { function() require "gitsigns".prev_hunk() end, "Prev Hunk" },
    l = { function() require "gitsigns".blame_line() end, "Blame" },
    p = { function() require "gitsigns".preview_hunk() end, "Preview Hunk" },
    r = { function() require "gitsigns".reset_hunk() end, "Reset Hunk" },
    R = { function() require "gitsigns".reset_buffer() end, "Reset Buffer" },
    s = { function() require "gitsigns".stage_hunk() end, "Stage Hunk" },
    u = { function() require "gitsigns".undo_stage_hunk() end, "Undo Stage Hunk" },
    o = { "<Cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<Cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<Cmd>Telescope git_comments<CR>", "Checkout commit" },
    C = { "<Cmd>Telescope git_bcommits<CR>", "Checkout commit (for current file)" },
    -- d = { "<Cmd>Gitsigns diffthis HEAD<CR>", "Git Diff" },
    d = { "<Cmd>DiffviewOpen<CR>", "Git Diff" },
    h = { "<Cmd>DiffviewFileHistory<CR>", "File History" },
  },
  s = {
    name = "Search",
    b = { "<Cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<Cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<Cmd>Telescope find_files<CR>", "Find File" },
    h = { "<Cmd>Telescope help_tags<CR>", "Find Help" },
    H = { "<Cmd>Telescope highlights<CR>", "Find Highlight Groups" },
    M = { "<Cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<Cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<Cmd>Telescope registers<CR>", "Registers" },
    t = { "<Cmd>Telescope live_grep<CR>", "Text" },
    k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
    C = { "<Cmd>Telescope commands<CR>", "Commands" },
    p = { function() require "telescope.builtin".colorscheme({ enable_preview = true }) end, "Colorscheme with Preview" },
  },
  T = {
    name = "Treesitter",
    i = { "<Cmd>TSConfigInfo<CR>", "Info" },
    m = { "<Cmd>TSModuleInfo<CR>", "Module Info" },
  },
}

local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}

local icons = require("user.icons")

whichkey.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  icons = {
    breadcrumb = icons.ui.DoubleChevronRight .. " ",
    separator = icons.ui.BoldArrowRight .. " ",
    group = icons.ui.Plus .. " ",
  },
  window = {
    border = "single",
  },
})

whichkey.register(mappings, opts)
whichkey.register(vmappings, vopts)
