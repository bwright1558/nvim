return {
  "ray-x/lsp_signature.nvim",
  config = function()
    local border = require("user.borders").style

    require("lsp_signature").setup({
      hint_enable = false,
      toggle_key = "<C-;>",
      handler_opts = {
        border = border,
      },
    })
  end,
}
