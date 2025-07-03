-------------------------------------------------------------------------------
-- smart_split.lua
--
-- A tiny helper that jumps to an existing split in the requested direction,
-- or creates one there if none exists. Works with the classic Vim direction
-- keys (h = left, j = down, k = up, l = right).
--
-- USAGE:
-- local split = require("smart_split")
-- split.focus("h") -- move/create left
--
-- Optionally map keys (example):
-- vim.keymap.set("n", "<C-h>", function() require("smart_split").focus("h") end)
-- vim.keymap.set("n", "<C-j>", function() require("smart_split").focus("j") end)
-- vim.keymap.set("n", "<C-k>", function() require("smart_split").focus("k") end)
-- vim.keymap.set("n", "<C-l>", function() require("smart_split").focus("l") end)
-------------------------------------------------------------------------------

local M = {}

-- lookup to force a split *into* the requested direction regardless of
-- splitbelow / splitright user settings.
local split_cmd = {
  h = "leftabove vsplit",  -- open at left and keep focus
  l = "rightbelow vsplit", -- open at right and keep focus
  k = "leftabove split",   -- open above
  j = "rightbelow split",  -- open below
}

-- Move to or create a split in the given direction.
-- @param dir 'h'|'j'|'k'|'l'
function M.focus(dir)
  if not split_cmd[dir] then
    vim.notify("smart_split.focus: dir must be h/j/k/l, got " .. tostring(dir), vim.log.levels.ERROR)
    return
  end

  local cur = vim.api.nvim_get_current_win() -- stable window handle
  vim.cmd("wincmd " .. dir)                  -- try to move first

  if cur == vim.api.nvim_get_current_win() then -- didn't move ⇒ need split
    -- Use pcall in case splitting is impossible (e.g. terminal / floating win)
    if pcall(vim.cmd, split_cmd[dir]) then
      vim.cmd("wincmd " .. dir) -- focus the new window
    end
  end
end

return M
