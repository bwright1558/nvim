local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = false,
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
  end,
}

return M
