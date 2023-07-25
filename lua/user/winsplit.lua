local M = {}

-- focus splits the window in the direction of the specified movement key.
-- If a split already exists in that direction, then cursor focus is moved
-- to the window in the direction of the specified movement key.
-- @param key The movement key. Can be one of "h", "j", "k", or "l".
function M.focus(key)
  local curwin = vim.api.nvim_win_get_number(0)
  vim.cmd("wincmd " .. key)

  if curwin == vim.api.nvim_win_get_number(0) then
    if key:match("[jk]") then
      vim.cmd("wincmd s")
    else
      vim.cmd("wincmd v")
    end
    vim.cmd("wincmd " .. key)
  end
end

return M
