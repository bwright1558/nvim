-------------------------------------------------------------------------------
-- map.lua
--
-- Helper functions for managing keymaps.
-------------------------------------------------------------------------------

local M = {}

-- Register a list of keymaps with shared default options.
--
-- Each keymap spec is a table shaped like:
-- { lhs, rhs, mode = "n" | { ... }, desc = "...", buffer = ..., remap = ..., ... }
--
-- Non-numeric fields on a spec are treated as `vim.keymap.set()` options, except
-- for `mode`, which is passed separately. List-level defaults are merged first,
-- then per-entry options override them.
--
-- @param keymaps table[] List of keymap specs.
-- @param defaults? table Shared default options applied to every keymap.
function M.register(keymaps, defaults)
  defaults = vim.tbl_extend("force", { silent = true }, defaults or {})

  for _, spec in ipairs(keymaps) do
    local opts = vim.deepcopy(defaults)

    for key, value in pairs(spec) do
      if type(key) ~= "number" and key ~= "mode" then
        opts[key] = value
      end
    end

    vim.keymap.set(spec.mode or "n", spec[1], spec[2], opts)
  end
end

return M
