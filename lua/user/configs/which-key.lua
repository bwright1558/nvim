local ok, whichkey = pcall(require, "which-key")
if not ok then
  return
end

local icons = require("user.icons")

whichkey.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  icons = {
    breadcrumb = icons.ui.DoubleChevronRight,
    separator = icons.ui.BoldArrowRight,
    group = icons.ui.Plus,
  },
})

-- Register normal-mode keymaps.
whichkey.register({}, {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
})

-- Register visual-mode keymaps.
whichkey.register({}, {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
})
