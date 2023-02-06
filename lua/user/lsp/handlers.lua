local M = {}

-- Helper function to set keymap for specific buffer with a description.
local function keymap(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
end

-- capabilities handler
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- on_attach handler
function M.on_attach(_, bufnr)
  keymap(bufnr, "n", "K", vim.lsp.buf.hover, "Show Hover")
  keymap(bufnr, "n", "gd", vim.lsp.buf.definition, "Goto Definition")
  keymap(bufnr, "n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  keymap(bufnr, "n", "gr", vim.lsp.buf.references, "Goto References")
  keymap(bufnr, "n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
  keymap(bufnr, "n", "gK", vim.lsp.buf.signature_help, "Show Signature Help")
  keymap(bufnr, "n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
  keymap(bufnr, "n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
  keymap(bufnr, "n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
end

return M
