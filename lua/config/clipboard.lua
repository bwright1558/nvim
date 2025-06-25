-- Wayland clipboard workaround:
-- Use xclip under XWayland to avoid flicker caused by wl-clipboard spawning windows.

local is_wayland = vim.env.WAYLAND_DISPLAY ~= nil
local has_xclip = vim.fn.executable("xclip") == 1

-- Check if XWayland is running by looking for a running X server
local xwayland_running = vim.fn.has("x11") == 1 or vim.fn.executable("xprop") == 1

if is_wayland and has_xclip and xwayland_running then
  vim.g.clipboard = {
    name = "xclip (Wayland workaround)",
    copy = {
      ["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
      ["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
    },
    paste = {
      ["+"] = { "xclip", "-o", "-selection", "clipboard" },
      ["*"] = { "xclip", "-o", "-selection", "primary" },
    },
    cache_enabled = true,
  }
end
