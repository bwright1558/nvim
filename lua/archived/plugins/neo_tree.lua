-- neo_tree.lua
--
-- File explorer for neovim.
--
-- See: https://github.com/nvim-neo-tree/neo-tree.nvim

local M = {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {
    -- popup_border_style = "rounded",
    default_component_configs = {
      icon = {
        default = "󰈙"
      },
      modified = { symbol = "" },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
    },
  },
}

return M
