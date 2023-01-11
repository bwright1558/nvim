local M = {
  "ray-x/go.nvim",
  ft = "go",
}

M.config = function()
  require("go").setup()
end

return M
