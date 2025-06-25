-- TODO: Autoformat json, lua, and go files on save (BufWritePre)

-------------------------------------------------------------------------------
-- autocmds.lua
--
-- Neovim autocmd orchestration
-- ----------------------------
-- * Global defaults (see options.lua): expandtab=true, shiftwidth=2, tabstop=2
-- * This file collects **all** autocmd-based behavior in one place so it's easy
--   to scan, extend, or disable. Everything is grouped and labelled.
-------------------------------------------------------------------------------
local api = vim.api

-------------------------------------------------------------------------------
-- Helper: augroup wrapper to keep a consistent "user_config_" prefix
-------------------------------------------------------------------------------
local function augroup(name)
  return api.nvim_create_augroup("user_config_" .. name, { clear = true })
end

-------------------------------------------------------------------------------
-- Helper: single shared augroup for *filetype* specific settings
-------------------------------------------------------------------------------
local ft_group = augroup("filetypes")

-- Register settings for one or more filetypes.
-- @param fts string|string[] filetype or list of filetypes
-- @param cb fun()            callback executed on FileType
local function ft(fts, cb)
  api.nvim_create_autocmd("FileType", {
    group = ft_group,
    pattern = fts,
    callback = cb,
  })
end

-------------------------------------------------------------------------------
-- FILETYPE-SPECIFIC OVERRIDES
-------------------------------------------------------------------------------
local ft_overrides = {
  -- spell + soft wrap for writing-heavy files
  { { "gitcommit", "markdown" }, function()
      vim.opt_local.spell = true
      vim.opt_local.wrap = true
    end },

  -- Makefiles → *hard* tabs, 4-space visual width
  { "make", function()
      vim.opt_local.expandtab = false
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
    end },

  -- Go → tabs, 8-space width
  { "go", function()
      vim.opt_local.expandtab = false
      vim.opt_local.shiftwidth = 8
      vim.opt_local.tabstop = 8
    end },

  -- Python & Rust → 4-space indent
  { { "python", "rust" }, function()
      vim.opt_local.expandtab = true
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
    end },
}

for _, spec in ipairs(ft_overrides) do
  ft(spec[1], spec[2])
end

-------------------------------------------------------------------------------
-- CUSTOM FILETYPE DETECTION (manual overrides)
-------------------------------------------------------------------------------
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("custom_filetypes"),
  pattern = {
    "*/.ebextensions/*.config",
    "*/ebextensions/*.config",
    "*.j2",
    "*/sway/config.d/*",
    "env",
    ".env",
    "env.*",
    ".env.*",
  },
  callback = function(args)
    local path = args.file

    if path:match("%.j2$") then
      -- Try to infer the original filetype by stripping the .j2
      local basename = path:gsub(".j2$", "")
      local inferred_ft = vim.filetype.match({ filename = basename })
      if not inferred_ft and basename:match("%.config$") then
        inferred_ft = "yaml" -- fallback for ebextensions/*.config.j2
      end
      if inferred_ft then
        vim.bo.filetype = inferred_ft
      end
    elseif path:match("%.config$") then
      vim.bo.filetype = "yaml"
    elseif path:match("sway/config%.d/") then
      vim.bo.filetype = "swayconfig"
    elseif path:match("^%.?env") then
      vim.bo.filetype = "sh"
    end
  end,
})

-------------------------------------------------------------------------------
-- GLOBAL AUTOCMDS (apply to *every* buffer)
-------------------------------------------------------------------------------

-- FormatOptions - remove automatic comment leader continuation (c r o)
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("formatopts"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Highlight on yank - visual feedback
api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Trim whitespace / blank lines on save - leverage existing :Trim* commands
api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_on_save"),
  callback = function()
    vim.cmd("silent TrimWhitespace")
    vim.cmd("silent TrimEOF")
  end,
})
