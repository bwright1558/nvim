return {
  "williamboman/mason.nvim",
  config = function()
    local border = require("user.borders").style

    require("mason").setup({
      ui = {
        border = border,
      },
    })
  end,
}
