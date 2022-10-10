local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Trim trailing whitespace and newlines on save.
autocmd({ "BufWritePre" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec("TrimWhitespace", false)
    vim.api.nvim_exec("TrimNewlines", false)
  end,
})

-- Format options (disables continuing comments on Enter)
autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Spell checking
autocmd({ "FileType" }, {
  group = group,
  pattern = { "gitcommit", "markdown" },
  callback = function() vim.opt_local.spell = true end,
})

-- Highlight on yank
autocmd({ "TextYankPost" }, {
  group = group,
  pattern = { "*" },
  callback = function() vim.highlight.on_yank() end,
})

-- Format on save
autocmd({ "BufWritePre" }, {
  group = group,
  pattern = { "*.json", "*.lua" },
  callback = function() vim.lsp.buf.format() end,
})
autocmd({ "BufWritePre" }, {
  group = group,
  pattern = { "*.go" },
  callback = function()
    require("go.format").goimport()
    vim.lsp.buf.format()
  end,
})

-- Set filetype for certain files with alternate file extension.
autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*/.ebextensions/*.config", "*.yml.j2" },
  callback = function() vim.opt_local.filetype = "yaml" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.json.j2" },
  callback = function() vim.opt_local.filetype = "json" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.conf.j2" },
  callback = function() vim.opt_local.filetype = "conf" end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "haproxy.cfg.j2" },
  callback = function() vim.opt_local.filetype = "haproxy" end,
})
