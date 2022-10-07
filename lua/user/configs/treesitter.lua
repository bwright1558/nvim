local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
