local icons = require("config.icons")

vim.diagnostic.config({
  severity_sort = true,
  float = {
    source = true,
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_config_lsp_attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", vim.lsp.buf.hover, "Show Hover")
    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gr", vim.lsp.buf.references, "Goto References")
    map("gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("gK", vim.lsp.buf.signature_help, "Show Signature Help")
    map("gl", vim.diagnostic.open_float, "Show Line Diagnostics")
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")
  end,
})
