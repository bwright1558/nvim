local M = {}

local icons = require("user.icons")

-- Helper function to set keymap for specific buffer with a description.
local keymap = function(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
end

M.setup = function()
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
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
end

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
