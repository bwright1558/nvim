-- indent_blankline.lua
--
-- Indent guides for neovim.
--
-- See: https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
  main = "ibl",
  opts = {
    indent = { char = "┃" },
    scope = { enabled = true },
  },
}

return M
