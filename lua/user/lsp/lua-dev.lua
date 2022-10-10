local ok, lua_dev = pcall(require, "lua-dev")
if not ok then
  return
end

lua_dev.setup({
  library = {
    plugins = false,
  },
  setup_jsonls = false,
})
