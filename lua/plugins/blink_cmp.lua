vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
}, { confirm = false })

require("blink.cmp").setup({
  completion = {
    menu = {
      border = "rounded",
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
          { "source_id" },
        },
      },
    },
    documentation = { window = { border = "rounded" } },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
  -- cmdline = { enabled = false },
})
