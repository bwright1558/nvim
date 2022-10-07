local ok, whichkey = pcall(require, "which-key")
if not ok then
  return
end

local opts = {
  mode = "n",
  prefix = "<leader>",
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
}

local mappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
}

local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}

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
  window = {
    border = "rounded",
  },
})

whichkey.register(mappings, opts)
whichkey.register(vmappings, vopts)
