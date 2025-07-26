-- snacks.lua
--
-- A collection of QoL plugins for neovim.
--
-- See: https://github.com/folke/snacks.nvim

local M = {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    git = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Autocmd to refresh indent guides after opening a window or filetype detection.
    -- This is a workaround because Snacks.indent doesn't enable on its own when opening a new file.
    local group = vim.api.nvim_create_augroup("SnacksIndentFix", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
      group = group,
      callback = function()
        Snacks.indent.enable()
      end,
    })
  end,
}

return M
