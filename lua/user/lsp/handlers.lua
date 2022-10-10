local M = {}

-- Helper function to set keymap for specific buffer with a description.
local keymap = function(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
end

-- capabilities handler
M.capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

-- on_attach handler
M.on_attach = function(client, bufnr)
  keymap(bufnr, "n", "K", vim.lsp.buf.hover, "Show Hover")
  keymap(bufnr, "n", "gd", vim.lsp.buf.definition, "Goto Definition")
  keymap(bufnr, "n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  keymap(bufnr, "n", "gr", vim.lsp.buf.references, "Goto References")
  keymap(bufnr, "n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
  keymap(bufnr, "n", "gs", vim.lsp.buf.signature_help, "Show Signature Help")
  keymap(bufnr, "n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
  keymap(bufnr, "n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
  keymap(bufnr, "n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
end

return M
