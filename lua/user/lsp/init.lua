local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local servers = {
  "bashls",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
  "vimls",
}

local handlers = require("user.lsp.handlers")
local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
}

handlers.setup()
require("user.lsp.lua-dev") -- XXX: consider putting in handlers.setup()
require("user.lsp.nlspsettings") -- XXX: consider putting in handlers.setup()

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup(opts)
  end,
})
