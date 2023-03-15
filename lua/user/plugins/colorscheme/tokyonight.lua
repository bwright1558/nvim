local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("tokyonight").setup({
    style = "storm",
    transparent = true,
  })

  vim.cmd.colorscheme("tokyonight")
end

return M
