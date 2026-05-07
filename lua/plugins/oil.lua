vim.pack.add({
  -- Depends on nvim-web-devicons
  "https://github.com/stevearc/oil.nvim",
}, { confirm = false })

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-s>"] = false, -- default is "actions.select" veritical split
    ["<C-h>"] = false, -- default is "actions.select" horizontal split
    ["<C-j>"] = false, -- no default
    ["<C-k>"] = false, -- no default
    ["<C-l>"] = false, -- default is "actions.refresh"
    ["<C-r>"] = "actions.refresh", -- no default
  },
})
