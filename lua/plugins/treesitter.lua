-- treesitter.lua
--
-- Plugin configuration for nvim-treesitter.
-- Provides incremental parsing and syntax-aware features
-- like highlighting, indentation, folding, etc.
--
-- See: https://github.com/nvim-treesitter/nvim-treesitter

local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",

  -- Uses the plugin's built-in setup function
  main = "nvim-treesitter.configs",

  opts = {
    -- Install all available maintained parsers,
    -- except for those explicitly ignored
    ensure_installed = "all",
    ignore_install = {
      "norg", -- causes build issues on some systems
    },

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",     -- Start selection
        node_incremental = "<CR>",   -- Expand to next node
        scope_incremental = "<Tab>", -- Expand to next scope
        node_decremental = "<BS>",   -- Shrink selection
      },
    },
  },
}

return M
