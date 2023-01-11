require("nlspsettings").setup({
  config_home = vim.fn.stdpath("config") .. "/lsp-settings",
  local_settings_dir = ".lsp-settings",
  local_settings_root_markers_fallback = { ".git" },
  append_default_schemas = true,
  loader = "json",
})
