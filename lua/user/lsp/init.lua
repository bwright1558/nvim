require("user.lsp.config")
require("user.lsp.neodev")
require("user.lsp.nlspsettings")

local servers = {
  "bashls",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  -- "marksman", -- doesn't work on arm processors
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

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup(opts)
  end,
})
