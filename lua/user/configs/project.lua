local ok, project = pcall(require, "project_nvim")
if not ok then
  return
end

project.setup({
  manual_mode = false,
  detection_methods = { "pattern" }, -- NOTE: lsp detection gets annoying with multiple langs in one project
  patterns = {
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    -- "Makefile",
    -- "package.json",
    -- "pom.xml",
  },
  show_hidden = false,
  silent_chdir = true,
  scope_chdir = "tab",
  ignore_lsp = {},
  datapath = vim.fn.stdpath("cache"),
})
