vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
}, { confirm = false })

require("mason").setup({
  ui = {
    border = "rounded",
  },
})
