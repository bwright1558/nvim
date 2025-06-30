-- render_markdown.lua
--
-- Improve viewing Markdown files in neovim.
--
-- See: https://github.com/MeanderingProgrammer/render-markdown.nvim

local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    latex = { enabled = false },
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
  },
}

return M
