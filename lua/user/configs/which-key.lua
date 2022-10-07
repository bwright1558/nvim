local ok, whichkey = pcall(require, "which-key")
if not ok then
  return
end

local opts = {
  mode = "n",
  prefix = "<Leader>",
}

local vopts = {
  mode = "v",
  prefix = "<Leader>",
}

local mappings = {
  ["q"] = { "<Cmd>q<CR>", "Quit" },
  ["w"] = { "<Cmd>w<CR>", "Save" },
  [";"] = { "<Cmd>Telescope filetypes<CR>", "Filetypes" },
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
