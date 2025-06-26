-- colorscheme.lua
--
-- Manage colorschemes for neovim.
--
-- See: https://github.com/catppuccin/nvim

local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}

return M
