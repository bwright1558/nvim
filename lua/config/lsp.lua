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
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Show Hover")
    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gr", vim.lsp.buf.references, "Goto References")
    map("gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Show Signature Help")
    map("gl", vim.diagnostic.open_float, "Show Line Diagnostics")
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")
  end,
})
