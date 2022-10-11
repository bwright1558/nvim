local ok, nightfox = pcall(require, "nightfox")
if not ok then
  return
end

-- Nightfox border background is not set by default. We override this option here.
-- TODO: Consider using a dimmer border foreground like `fg = "bg4"` (telescope default).
local border = { fg = "fg3", bg = "bg0" }
local normal = { fg = "fg1", bg = "bg0" }

-- Make float backgrounds darker than the editing area.
local groups = {
  all = {
    NormalFloat = normal,
    FloatBorder = border,

    TelescopeNormal = normal,
    TelescopeBorder = border,

    BqfPreviewFloat = normal,
    BqfPreviewBorder = border,
  },
}

nightfox.setup({
  -- options = {
  --   styles = {
  --     comments = "italic",
  --     keywords = "italic",
  --   },
  -- },
  groups = groups,
})

-- Use pcall because colorscheme plugin may not exist, yet.
pcall(function()
  vim.cmd [[colorscheme nightfox]]
end)
