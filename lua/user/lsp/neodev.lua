local ok, neodev = pcall(require, "neodev")
if not ok then
  return
end

neodev.setup({
  library = {
    plugins = false,
  },
  setup_jsonls = false,
})
