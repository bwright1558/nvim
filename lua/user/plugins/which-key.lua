local M = {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
}

function M.config()
  -- Smartly opens either git_files or find_files, depending on whether the
  -- working directory is contained in a Git repo.
  local function find_project_files()
    local git_files_ok = pcall(function() vim.cmd("Telescope git_files") end)
    if not git_files_ok then
      vim.cmd("Telescope find_files")
    end
  end

  -- Toggle quickfix window.
  local function toggle_quickfix()
    local fn = vim.fn
    if #fn.filter(fn.getwininfo(), "v:val.quickfix") == 0 then
      vim.cmd("copen")
    else
      vim.cmd("cclose")
    end
  end

  local mappings = {
    mode = { "n" },
    { "<Leader>;",  "<Cmd>Telescope filetypes<CR>",                                                     desc = "Filetypes" },
    { "<Leader>/",  "<Plug>(comment_toggle_linewise_current)",                                          desc = "Comment toggle current line" },
    { "<Leader>,",  toggle_quickfix,                                                                    desc = "QuickFix" },
    { "<Leader>q",  "<Cmd>q<CR>",                                                                       desc = "Quit" },
    { "<Leader>Q",  "<Cmd>qall<CR>",                                                                    desc = "Quit All" },
    { "<Leader>w",  "<Cmd>w<CR>",                                                                       desc = "Save" },
    { "<Leader>c",  "<Cmd>bd<CR>",                                                                      desc = "Close Buffer" },
    { "<Leader>f",  find_project_files,                                                                 desc = "Find File" },
    { "<Leader>h",  "<Cmd>nohlsearch<CR>",                                                              desc = "No Highlight" },
    { "<Leader>e",  "<Cmd>NvimTreeToggle<CR>",                                                          desc = "Explorer" },
    { "<Leader>p",  "<Cmd>Lazy<CR>",                                                                    desc = "Plugins" },

    { "<Leader>b",  group = "Buffers" },
    { "<Leader>bf", "<Cmd>Telescope buffers<CR>",                                                       desc = "Find" },
    { "<Leader>bj", "<Cmd>bn<CR>",                                                                      desc = "Next" },
    { "<Leader>bk", "<Cmd>bp<CR>",                                                                      desc = "Previous" },

    { "<Leader>g",  group = "Git" },
    { "<Leader>g;", "<Cmd>Git push<CR>",                                                                desc = "Git Push" }, -- for best experience, use `git config --global push.autoSetupRemote true`
    { "<Leader>gg", "<Cmd>G<CR>",                                                                       desc = "Git Status" },
    { "<Leader>gj", function() require("gitsigns").next_hunk() end,                                     desc = "Next Hunk" },
    { "<Leader>gk", function() require("gitsigns").prev_hunk() end,                                     desc = "Prev Hunk" },
    { "<Leader>gl", function() require("gitsigns").blame_line() end,                                    desc = "Blame" },
    { "<Leader>gp", function() require("gitsigns").preview_hunk() end,                                  desc = "Preview Hunk" },
    { "<Leader>gr", function() require("gitsigns").reset_hunk() end,                                    desc = "Reset Hunk" },
    { "<Leader>gR", function() require("gitsigns").reset_buffer() end,                                  desc = "Reset Buffer" },
    { "<Leader>gs", function() require("gitsigns").stage_hunk() end,                                    desc = "Stage Hunk" },
    { "<Leader>gu", function() require("gitsigns").undo_stage_hunk() end,                               desc = "Undo Stage Hunk" },
    { "<Leader>go", "<Cmd>Telescope git_status<CR>",                                                    desc = "Open changed file" },
    { "<Leader>gb", "<Cmd>Telescope git_branches<CR>",                                                  desc = "Checkout branch" },
    -- { "<Leader>gc", "<Cmd>Telescope git_comments<CR>",                                                  desc = "Checkout commit" },
    { "<Leader>gC", "<Cmd>Telescope git_bcommits<CR>",                                                  desc = "Checkout commit (for current file)" },
    { "<Leader>gh", "<Cmd>DiffviewFileHistory<CR>",                                                     desc = "File History" },
    { "<Leader>gd", "<Cmd>DiffviewOpen<CR>",                                                            desc = "Git Diff" },
    -- { "<Leader>gd", "<Cmd>Gitsigns diffthis HEAD<CR>",                    desc = "Git Diff" },

    { "<Leader>l",  group = "LSP" },
    { "<Leader>la", vim.lsp.buf.code_action,                                                            desc = "Code Action" },
    { "<Leader>ld", "<Cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>",                             desc = "Buffer Diagnostics" },
    { "<Leader>lw", "<Cmd>Telescope diagnostics<CR>",                                                   desc = "Diagnostics" },
    { "<Leader>lf", vim.lsp.buf.format,                                                                 desc = "Format" },
    { "<Leader>li", "<Cmd>LspInfo<CR>",                                                                 desc = "Info" },
    { "<Leader>lI", "<Cmd>Mason<CR>",                                                                   desc = "Mason Info" },
    { "<Leader>lj", vim.diagnostic.goto_next,                                                           desc = "Next Diagnostic" },
    { "<Leader>lk", vim.diagnostic.goto_prev,                                                           desc = "Prev Diagnostic" },
    { "<Leader>ll", vim.lsp.codelens.run,                                                               desc = "CodeLens Action" },
    { "<Leader>lq", vim.diagnostic.setloclist,                                                          desc = "Quickfix" },
    { "<Leader>lr", vim.lsp.buf.rename,                                                                 desc = "Rename" },
    { "<Leader>lR", "<Cmd>LspRestart<CR>",                                                              desc = "Restart" },
    { "<Leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>",                                          desc = "Document Symbols" },
    { "<Leader>lS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>",                                 desc = "Workspace Symbols" },
    { "<Leader>le", "<Cmd>Telescope quickfix<CR>",                                                      desc = "Telescope Quickfix" },

    { "<Leader>s",  group = "Search" },
    { "<Leader>sb", "<Cmd>Telescope git_branches<CR>",                                                  desc = "Checkout branch" },
    { "<Leader>sc", "<Cmd>Telescope colorscheme<CR>",                                                   desc = "Colorscheme" },
    { "<Leader>sf", "<Cmd>Telescope find_files<CR>",                                                    desc = "Find File" },
    { "<Leader>sh", "<Cmd>Telescope help_tags<CR>",                                                     desc = "Find Help" },
    { "<Leader>sH", "<Cmd>Telescope highlights<CR>",                                                    desc = "Find Highlight Groups" },
    { "<Leader>sM", "<Cmd>Telescope man_pages<CR>",                                                     desc = "Man Pages" },
    { "<Leader>sr", "<Cmd>Telescope oldfiles<CR>",                                                      desc = "Open Recent File" },
    { "<Leader>sR", "<Cmd>Telescope registers<CR>",                                                     desc = "Registers" },
    { "<Leader>st", "<Cmd>Telescope live_grep<CR>",                                                     desc = "Text" },
    { "<Leader>sk", "<Cmd>Telescope keymaps<CR>",                                                       desc = "Keymaps" },
    { "<Leader>sC", "<Cmd>Telescope commands<CR>",                                                      desc = "Commands" },
    { "<Leader>sp", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Colorscheme with Preview" },

    { "<Leader>t",  group = "Treesitter" },
    { "<Leader>Ti", "<Cmd>TSConfigInfo<CR>",                                                            desc = "Info" },
    { "<Leader>Tm", "<Cmd>TSModuleInfo<CR>",                                                            desc = "Module Info" },
  }

  local vmappings = {
    mode = { "v" },
    { "<Leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment toggle linewise (visual)" },
  }

  local icons = require("user.icons")
  local border = require("user.borders").style

  local whichkey = require("which-key")
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
    win = {
      border = border,
    },
  })

  whichkey.add(mappings)
  whichkey.add(vmappings)
end

return M
