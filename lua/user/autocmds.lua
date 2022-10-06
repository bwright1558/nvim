local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace and newlines on save.
autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec("TrimWhitespace", false)
    vim.api.nvim_exec("TrimNewlines", false)
  end,
})

-- Set filetype for certain files with alternate file extension.
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/.ebextensions/*.config", "*.yml.j2" },
  callback = function() vim.opt_local.filetype = "yaml" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json.j2" },
  callback = function() vim.opt_local.filetype = "json" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.conf.j2" },
  callback = function() vim.opt_local.filetype = "conf" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "haproxy.cfg.j2" },
  callback = function() vim.opt_local.filetype = "haproxy" end,
})

-- Run gofmt + goimport on save.
autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function()
    require("go.format").goimport()
    vim.lsp.buf.formatting_seq_sync({})
  end,
})
