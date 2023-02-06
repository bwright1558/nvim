local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  enabled = true,
}

function M.config()
  require("tokyonight").setup({
    style = "storm",
  })

  vim.cmd [[colorscheme tokyonight]]
end

return M
