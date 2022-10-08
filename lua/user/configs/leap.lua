local ok, leap = pcall(require, "leap")
if not ok then
  return
end

-- vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#606c7e" })
leap.set_default_keymaps()
