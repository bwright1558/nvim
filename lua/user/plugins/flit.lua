local M = {
  "ggandor/flit.nvim",
  dependencies = {
    "ggandor/leap.nvim",
  },
  event = "VeryLazy",
}

function M.config()
  require("flit").setup({
    labeled_modes = "nv",
  })
end

return M
