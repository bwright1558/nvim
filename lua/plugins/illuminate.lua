-- illuminate.lua
--
-- Highlights other occurrences of the word under the cursor.
-- Uses LSP, Treesitter, and regex for intelligent reference highlighting.
--
-- See https://github.com/RRethy/vim-illuminate

local M = {
  "RRethy/vim-illuminate",
  enabled = false,
  event = { "CursorHold", "CursorHoldI" },
  opts = {
    providers = { "lsp" },
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "lazy",
      "neogitstatus",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
    },
    large_file_cutoff = 100000,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}

return M
