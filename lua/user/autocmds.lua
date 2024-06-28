local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

local function autoft(ft, pattern)
  autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = pattern,
    callback = function() vim.opt_local.filetype = ft end,
  })
end

-- Trim trailing whitespace and newlines on save.
autocmd({ "BufWritePre" }, {
  group = group,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec2("TrimWhitespace", {})
    vim.api.nvim_exec2("TrimNewlines", {})
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
  end,
})

-- Set filetype for certain files with alternate file extension.
autoft("yaml", { "*/.ebextensions/*.config", "*.yml.j2" })
autoft("json", { "*.json.j2" })
autoft("conf", { "*.conf.j2" })
autoft("haproxy", { "haproxy.cfg.j2" })
autoft("swayconfig", { "*/sway/config.d/*" })
autoft("sh", { "env", ".env", "env.*", ".env.*" })
autoft("hurl", { "*.hurl" })
