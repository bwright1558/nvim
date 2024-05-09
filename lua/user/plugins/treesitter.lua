local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
  event = "VeryLazy",
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
      enable = true, -- there's some wonky indent crap with *.tsx files.
      disable = { "python", "yaml" },
    },
  })
end

return M
