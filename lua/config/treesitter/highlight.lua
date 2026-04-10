local M = {}

---@param filetypes string[]
function M.enable(filetypes)
  local group = vim.api.nvim_create_augroup("user_config_treesitter_start", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = filetypes,
    callback = function()
      if vim.bo.buftype ~= "" then
        return
      end
      pcall(vim.treesitter.start)
    end,
  })
end

return M
