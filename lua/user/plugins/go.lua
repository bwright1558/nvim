local M = {
  "ray-x/go.nvim",
  ft = "go",
}

function M.config()
  require("go").setup()
end

return M
