vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
}, { confirm = false })

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "󰐊" },
    topdelete = { text = "󰐊" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  current_line_blame = true,
  preview_config = {
    border = "rounded",
  },
})
