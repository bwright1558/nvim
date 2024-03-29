local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
}

function M.config()
  require("nvim-autopairs").setup({
    check_ts = true,
    fast_wrap = {
      map = "<C-,>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%)%>%]%)%}%,]]=],
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  })
end

return M
