local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
    "tamago324/nlsp-settings.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
}

M.config = function()
  require("user.lsp")
end

return M
