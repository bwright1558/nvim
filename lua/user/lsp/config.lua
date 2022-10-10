local icons = require("user.icons")
local border = require("user.borders").style

local sign = function(name, text)
  vim.fn.sign_define(name, { texthl = name, text = text, numhl = name })
end

sign("DiagnosticSignError", icons.diagnostics.Error)
sign("DiagnosticSignWarn", icons.diagnostics.Warning)
sign("DiagnosticSignHint", icons.diagnostics.Hint)
sign("DiagnosticSignInfo", icons.diagnostics.Info)

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = border,
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
