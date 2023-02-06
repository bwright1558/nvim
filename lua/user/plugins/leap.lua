local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
}

function M.config()
  vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
  vim.api.nvim_set_hl(0, "LeapMatch", {
    fg = "white", -- for light themes, set to "black" or similar
    bold = true,
    nocombine = true,
  })

  local leap = require("leap")
  leap.opts.highlight_unlabeled_phase_one_targets = true
  leap.add_default_mappings(true)
end

return M
