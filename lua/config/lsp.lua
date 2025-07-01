vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
})

-- -- wrap hover
-- local _hover = vim.lsp.buf.hover
-- vim.lsp.buf.hover = function(opts)
--   opts = opts or {}
--   opts.border = opts.border or "rounded"
--   return _hover(opts)
-- end
--
-- -- wrap signature help
-- local _sig = vim.lsp.buf.signature_help
-- vim.lsp.buf.signature_help = function(opts)
--   opts = opts or {}
--   opts.border = "rounded"
--   return _sig(opts)
-- end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_config_lsp_attach", { clear = true }),
  callback = function(event)

    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc, silent = true })
    end

    -- Core LSP mappings
    map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover Documentation")
    map("n", "gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature Help")
    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
    -- map("n", "gr", vim.lsp.buf.references, "Goto References")
    map("n", "gr", function() Snacks.picker.lsp_references() end, "References")
    map("n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")

    -- <Leader> LSP mappings
    map("n", "<Leader>la", vim.lsp.buf.code_action, "Code Action")
    map("x", "<Leader>la", vim.lsp.buf.code_action, "Code Action (Visual)")
    map("n", "<Leader>lf", vim.lsp.buf.format, "Format")
    map("n", "<Leader>lr", vim.lsp.buf.rename, "Rename Symbol")
    map("n", "<Leader>lj", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map("n", "<Leader>lk", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")
    map("n", "<Leader>ll", vim.lsp.codelens.run, "Run CodeLens")
    map("n", "<Leader>lq", vim.diagnostic.setloclist, "Diagnostics → Loclist")
    map("n", "<Leader>ld", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
    map("n", "<Leader>lw", function() Snacks.picker.diagnostics() end, "Workspace Diagnostics")
    map("n", "<Leader>ls", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
    map("n", "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
    map("n", "<Leader>li", "<Cmd>LspInfo<CR>", "LSP Info")
    map("n", "<Leader>lR", "<Cmd>LspRestart<CR>", "Restart LSP")
  end,
})
