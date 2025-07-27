-- lualine.lua
--
-- A pretty status line for neovim.
--
-- See: https://github.com/nvim-lualine/lualine.nvim

local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      globalstatus = vim.opt.laststatus == 3,
      disabled_filetypes = {
        statusline = { "NvimTree", "neo-tree", "Outline", "snacks_layout_box" },
      },
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            return gitsigns
                and {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              or {}
          end,
        },
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
      },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype", "progress", "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

return M
