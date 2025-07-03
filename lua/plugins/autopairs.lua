-- autopairs.lua
--
-- See: https://github.com/windwp/nvim-autopairs

local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    fast_wrap = {},
  },
}

return M
