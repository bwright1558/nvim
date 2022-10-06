local ok, nlspsettings = pcall(require, "nlspsettings")
if not ok then
  return
end

nlspsettings.setup({
  config_home = vim.fn.stdpath("config") .. "/lsp-settings",
  append_default_schemas = true,
  loader = "json",
})
