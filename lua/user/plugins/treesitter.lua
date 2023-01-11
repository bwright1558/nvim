local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
}

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "python", "yaml" },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
end

return M
