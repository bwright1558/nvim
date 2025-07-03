-- lazydev.lua
--
-- LSP enhancements for Lua development in Neovim.
-- Filetype-based lazy loading for Lua files only.
--
-- See: https://github.com/folke/lazydev.nvim

local M = {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}

return M
