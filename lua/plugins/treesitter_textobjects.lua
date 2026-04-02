local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local swap = require("nvim-treesitter-textobjects.swap")

    -- stylua: ignore start
    local keymaps = {
      -- select
      { "af", function() select.select_textobject("@function.outer", "textobjects") end, desc = "Select outer part of a function region", mode = { "x", "o" } },
      { "if", function() select.select_textobject("@function.inner", "textobjects") end, desc = "Select inner part of a function region", mode = { "x", "o" } },
      { "ac", function() select.select_textobject("@class.outer", "textobjects") end, desc = "Select outer part of a class region", mode = { "x", "o" } },
      { "ic", function() select.select_textobject("@class.inner", "textobjects") end, desc = "Select inner part of a class region", mode = { "x", "o" } },
      { "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, desc = "Select outer part of a parameter region", mode = { "x", "o" } },
      { "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, desc = "Select inner part of a parameter region", mode = { "x", "o" } },
      { "as", function() select.select_textobject("@local.scope", "locals") end, desc = "Select language scope", mode = { "x", "o" } },

      -- move
      { "]m", function() move.goto_next_start("@function.outer", "textobjects") end, desc = "Next function start", mode = { "n", "x", "o" } },
      { "]c", function() move.goto_next_start("@class.outer", "textobjects") end, desc = "Next class start", mode = { "n", "x", "o" } },
      { "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, desc = "Previous function start", mode = { "n", "x", "o" } },
      { "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, desc = "Previous class start", mode = { "n", "x", "o" } },

      -- swap
      { "<Leader>a", function() swap.swap_next("@parameter.inner", "textobjects") end, desc = "Swap next parameter" },
      { "<Leader>A", function() swap.swap_previous("@parameter.inner", "textobjects") end, desc = "Swap previous parameter" },
    }
    -- stylua: ignore end

    for _, map in ipairs(keymaps) do
      local lhs, rhs, opts = map[1], map[2], { desc = map.desc, silent = true }
      if map.remap then
        opts.remap = map.remap
      end
      vim.keymap.set(map.mode or "n", lhs, rhs, opts)
    end
  end,
}

return M
