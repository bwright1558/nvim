local ok, mason = pcall(require, "mason")
if not ok then
  return
end

local border = require("user.borders").style

mason.setup({
  ui = {
    border = border,
  },
})
