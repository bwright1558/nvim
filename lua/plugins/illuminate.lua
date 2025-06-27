-- illuminate.lua
--
-- Highlights other occurrences of the word under the cursor.
-- Uses LSP, Treesitter, and regex for intelligent reference highlighting.
--
-- See https://github.com/RRethy/vim-illuminate

local M = {
  "RRethy/vim-illuminate",
  event = { "CursorHold", "CursorHoldI" },
  opts = {},
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}

return M
