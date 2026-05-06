--- commands.lua
---
--- Collection of handy :User commands:
---   :TrimWhitespace      - remove all trailing spaces/tabs in current buffer
---   :TrimEOF             - remove *extra* blank lines at EOF (leave at most 1)
---   :Format              - LSP-format the current buffer (blocking by default, async with !)
---   :SplitLeft / :SplitDown / :SplitUp / :SplitRight - smart split navigation
---   :LspInfo / :LspStart / :LspStop / :LspRestart / :LspLog - LSP command aliases

--- Save & restore cursor / view
local function preserve_view(fn)
  local view = vim.fn.winsaveview()
  fn()
  vim.fn.winrestview(view)
end

-- Trim trailing whitespace
vim.api.nvim_create_user_command("TrimWhitespace", function()
  preserve_view(function()
    -- Vim-regex: \s = whitespace, \+ = one or more, //e = no error if none.
    vim.cmd([[silent keeppatterns %s/\s\+$//e]])
  end)
  print("Trailing whitespace removed")
end, { desc = "Remove all trailing whitespace in buffer" })

-- Trim extra blank lines at EOF
-- Leaves *one* final newline (POSIX-friendly).
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

-- LSP format

-- Conform version of `Format`
vim.api.nvim_create_user_command("Format", function(opts)
  local range = nil
  if opts.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, opts.line2 - 1, opts.line2, true)[1]
    range = {
      start = { opts.line1, 0 },
      ["end"] = { opts.line2, end_line:len() },
    }
  end
  require("conform").format({ async = opts.bang, range = range, lsp_format = "fallback" })
end, {
  bang = true,
  range = true,
  desc = "LSP format current buffer (add ! for async)",
})

-- LSP version of `Format`
-- vim.api.nvim_create_user_command("Format", function(opts)
--   local range = nil
--   if opts.count ~= -1 then
--     local end_line = vim.api.nvim_buf_get_lines(0, opts.line2 - 1, opts.line2, true)[1]
--     range = {
--       start = { opts.line1, 0 },
--       ["end"] = { opts.line2, end_line:len() },
--     }
--   end
--
--   local ok = pcall(vim.lsp.buf.format, { async = opts.bang, range = range })
--   if not ok then vim.notify("No attached LSP client supports formatting", vim.log.levels.WARN) end
-- end, {
--   bang = true,
--   range = true,
--   desc = "LSP format current buffer (add ! for async)",
-- })

-- Smart split navigation / creation

local window = require("utils.window")

local split_cmds = {
  SplitLeft = { key = "h", desc = "Focus or create split to the left" },
  SplitDown = { key = "j", desc = "Focus or create split downward" },
  SplitUp = { key = "k", desc = "Focus or create split upward" },
  SplitRight = { key = "l", desc = "Focus or create split to the right" },
}
for name, def in pairs(split_cmds) do
  vim.api.nvim_create_user_command(name, function()
    window.focus(def.key)
  end, { desc = def.desc })
end

-- LSP commands

local function run_lsp_subcommand(subcommand, opts)
  local args = { subcommand }
  vim.list_extend(args, opts.fargs)
  vim.cmd.lsp({ args = args })
end

local function complete_lsp_configs(arg_lead)
  return vim.fn.getcompletion("lsp enable " .. arg_lead, "cmdline")
end

local function complete_lsp_clients(arg_lead)
  local seen = {}
  local clients = {}

  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name:sub(1, #arg_lead) == arg_lead and not seen[client.name] then
      seen[client.name] = true
      table.insert(clients, client.name)
    end
  end

  table.sort(clients)
  return clients
end

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, { desc = "Show LSP health and status" })

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew(vim.lsp.log.get_filename())
end, { desc = "Open the LSP client log" })

vim.api.nvim_create_user_command("LspStart", function(opts)
  run_lsp_subcommand("enable", opts)
end, {
  complete = complete_lsp_configs,
  desc = "Enable LSP config(s)",
  nargs = "*",
})

vim.api.nvim_create_user_command("LspStop", function(opts)
  run_lsp_subcommand("stop", opts)
end, {
  complete = complete_lsp_clients,
  desc = "Stop LSP client(s)",
  nargs = "*",
})

vim.api.nvim_create_user_command("LspRestart", function(opts)
  run_lsp_subcommand("restart", opts)
end, {
  complete = complete_lsp_clients,
  desc = "Restart LSP client(s)",
  nargs = "*",
})
