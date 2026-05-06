vim.pack.add({
  -- Depends on mason.nvim
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
}, { confirm = false })

require("mason-tool-installer").setup({
  ensure_installed = {
    -- Formatters
    "gofumpt",
    "goimports",
    "isort",
    "ruff",
    "taplo",
    "prettierd",
    "stylua",
    "shfmt",
  },
  auto_update = true,
  run_on_start = true,
})

require("conform").setup({
  format_on_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    -- This prevents autoformat for the specified filetypes, but the configured
    -- formatter can still be used when the document is formatted manually (by user command or keymap).
    local ignore_filetypes = {}
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    -- By setting `lsp_format = "never"`, conform will only format the
    -- file type using the formatter specified in `formatters_by_ft`.
    return { timeout_ms = 30000, lsp_format = "never" }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    fish = { "fish_indent" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    go = { "goimports", "gofumpt" },
    -- python = { "isort" },
    python = { "ruff_organize_imports" },
    -- python = { "ruff_fix", "ruff_format" },
    rust = { "rustfmt" },
    -- toml = { "taplo" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    -- json = { "prettierd" },
    -- yaml = { "prettierd" },
    graphql = { "prettierd" },
    -- markdown = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    jsx = { "prettierd" },
    vue = { "prettierd" },
  },
})
