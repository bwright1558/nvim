local M = {
  "folke/persistence.nvim",
  event = "BufReadPre",
}

function M.config()
  require("persistence").setup({
    options = {
      "buffers",
      "curdir",
      "tabpages",
      "winsize",
      "help",
    },
  })
end

return M
