vim.schedule(function()
  vim.pack.add({
    -- Depends on nvim-web-devicons
    "https://github.com/folke/which-key.nvim",
  }, { confirm = false })

  local wk = require("which-key")
  wk.setup({
    preset = "helix", -- classic, modern, helix
    icons = {
      group = " ",
      separator = " ",
      breadcrumb = "» ",
    },
    win = {
      border = "rounded",
    },
  })
  wk.add({
    mode = { "n", "x" },
    { "<Leader>b", group = "Buffers" },
    { "<Leader>f", group = "Files" },
    { "<Leader>g", group = "Git" },
    { "<Leader>l", group = "LSP" },
    { "<Leader>q", group = "Quickfix" },
    { "<Leader>x", group = "Trouble" },
    { "<Leader>s", group = "Search" },
    { "<Leader>t", group = "Treesitter" },
    { "<Leader>u", group = "UI/UX" },
    { "<Leader>w", group = "Windows" },
    { "<Leader><Tab>", group = "Tabs" },
  })
end)
