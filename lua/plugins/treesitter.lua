-- treesitter.lua
--
-- Plugin configuration for nvim-treesitter.
-- Provides incremental parsing and syntax-aware features
-- like highlighting, indentation, folding, etc.
--
-- See: https://github.com/nvim-treesitter/nvim-treesitter

local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "andymass/vim-matchup",
  },
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
      "ipkg",
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

    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Jump forward to textobj, like `]]`

        keymaps = {
          -- Use `a` for around and `i` for inner
          ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
          ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
          ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<Leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<Leader>A"] = "@parameter.inner",
        },
      },
    },

    matchup = {
      enable = true,
    },
  },
}

return M
