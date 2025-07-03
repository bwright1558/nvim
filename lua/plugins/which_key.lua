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
    preset = "helix", -- classic, modern, helix
    icons = {
      group = " ",
      separator = " ",
      breadcrumb = "» ",
    },
    win = {
      border = "rounded",
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
      { "<Leader>x", group = "Diagnostics/Quickfix" },
      { "<Leader>s", group = "Search" },
      { "<Leader>t", group = "Treesitter" },
      { "<Leader>u", group = "UI/UX" },
    })
  end,
}

return M
