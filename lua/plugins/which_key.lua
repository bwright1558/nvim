-- which_key.lua
--
-- Help to remember keymaps.
--
-- See: https://github.com/folke/which-key.nvim

local M = {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    preset = "modern", -- classic, modern, helix
    icons = {
      group = " ",
      separator = " ",
      breadcrumb = "» ",
    },
    win = {
      border = "rounded",
    },
  },
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      mode = { "n", "x" },
      { "<Leader>b", group = "Buffers" },
      { "<Leader>f", group = "Files" },
      { "<Leader>g", group = "Git" },
      { "<Leader>l", group = "LSP" },
      { "<Leader>s", group = "Search" },
      { "<Leader>t", group = "Treesitter" },
    })
  end,
}

return M
