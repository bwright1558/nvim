vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
}, { confirm = false })

require("catppuccin").setup({
  flavour = "mocha",
  show_end_of_buffer = true,
  auto_integrations = true,
})
vim.cmd.colorscheme("catppuccin")
