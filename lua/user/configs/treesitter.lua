local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "yaml" },
  },
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
