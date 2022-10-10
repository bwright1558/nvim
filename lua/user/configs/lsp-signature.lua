local ok, lsp_signature = pcall(require, "lsp_signature")
if not ok then
  return
end

local border = require("user.borders").style

lsp_signature.setup({
  hint_enable = false,
  toggle_key = "<C-;>",
  handler_opts = {
    border = border,
  },
})
