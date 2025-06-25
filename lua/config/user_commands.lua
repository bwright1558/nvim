-------------------------------------------------------------------------------
-- user_commands.lua
--
-- Collection of handy :User commands:
--   :TrimWhitespace      - remove all trailing spaces/tabs in current buffer
--   :TrimEOF             - remove *extra* blank lines at EOF (leave at most 1)
--   :Format              - LSP-format the current buffer (blocking by default, async with !)
--   :SplitLeft / :SplitDown / :SplitUp / :SplitRight - smart split navigation
--
-------------------------------------------------------------------------------

-- Utility: save & restore cursor / view -------------------------------------------------
local function preserve_view(fn)
  local view = vim.fn.winsaveview()
  fn()
  vim.fn.winrestview(view)
end

-------------------------------------------------------------------------------
-- Trim trailing whitespace
-------------------------------------------------------------------------------
vim.api.nvim_create_user_command("TrimWhitespace", function()
  preserve_view(function()
    -- Vim-regex: \s = whitespace, \+ = one or more, //e = no error if none.
    vim.cmd([[silent keeppatterns %s/\s\+$//e]])
  end)
  print("Trailing whitespace removed")
end, { desc = "Remove all trailing whitespace in buffer" })

-------------------------------------------------------------------------------
-- Trim extra blank lines at EOF
-- Leaves *one* final newline (POSIX-friendly).
-------------------------------------------------------------------------------
vim.api.nvim_create_user_command("TrimEOF", function()
  preserve_view(function()
    local last = vim.fn.line("$")
    -- Remove blank lines from the end until we hit a non-blank.
    while last > 1 and vim.fn.getline(last):match([[^%s*$]]) do
      vim.api.nvim_buf_set_lines(0, last - 1, last, false, {})
      last = last - 1
    end
  end)
  print("Trailing blank lines trimmed")
end, { desc = "Remove extraneous blank lines at end of file" })

-------------------------------------------------------------------------------
-- LSP format
-------------------------------------------------------------------------------
vim.api.nvim_create_user_command("Format", function(opts)
  local ok = pcall(vim.lsp.buf.format, { async = opts.bang })
  if not ok then
    vim.notify("No attached LSP client supports formatting", vim.log.levels.WARN)
  end
end, {
  bang = true,
  desc = "LSP format current buffer (add ! for async)",
})

-------------------------------------------------------------------------------
-- Smart split navigation / creation
-------------------------------------------------------------------------------
local split = require("config.smart_split")

local split_cmds = {
  SplitLeft  = { key = "h", desc = "Focus or create split to the left" },
  SplitDown  = { key = "j", desc = "Focus or create split downward" },
  SplitUp    = { key = "k", desc = "Focus or create split upward" },
  SplitRight = { key = "l", desc = "Focus or create split to the right" },
}
for name, def in pairs(split_cmds) do
  vim.api.nvim_create_user_command(name, function()
    split.focus(def.key)
  end, { desc = def.desc })
end
