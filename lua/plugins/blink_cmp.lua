-- blink_cmp.lua
--
-- Only overrides necessary options to achieve:
-- - VSCode-style menu layout
-- - super-tab keymap (Tab to confirm)
-- - LSP + snippet + path + buffer sources
-- - Signature help enabled.
--
-- See: https://github.com/saghen/blink.cmp

local M = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  version = "1.*",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    completion = {
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_id" },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = {
      enabled = true,
    },
  },
  opts_extend = { "sources.default" },
}

return M
