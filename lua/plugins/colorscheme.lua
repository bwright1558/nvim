-- colorscheme.lua
--
-- Manage colorschemes for neovim.
--
-- See: https://github.com/catppuccin/nvim

local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    show_end_of_buffer = true,
    auto_integrations = true,
    -- integrations = {
    --   grug_far = true,
    --   mason = true,
    --   lsp_trouble = true,
    --   snacks = { enabled = true },
    --   which_key = true,
    -- },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}

return M
