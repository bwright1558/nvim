local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
  return
end

mason.setup({
  ui = {
    border = "rounded",
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    "pyright",
  },
  automatic_installation = {
    exclude = {},
  },
})

mason_lspconfig.setup_handlers({
  function(server_name)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

    local opts = {
      capabilities = capabilities,
    }
    lspconfig[server_name].setup(opts)
  end,
})
