-- telescope.lua
--
-- Find, filter, preview, and pick.
--
-- See: https://github.com/nvim-telescope/telescope.nvim

local M = {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart", "filename_first" },
        layout_strategy = "flex",

        -- Override live_grep command to include hidden files and exclude .git
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!**/.git/*",
        },
        mappings = {
          i = {
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<Down>"] = actions.cycle_history_next,
            ["<Up>"] = actions.cycle_history_prev,
          },
        },
      },
      pickers = {
        find_files = {
          -- Override find_files command to include hidden files and exclude .git
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}

return M
