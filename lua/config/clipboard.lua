-- wl-clipboard causes a new empty window to very briefly get focus and quickly close.
-- This results in the terminal flickering, esp. nvim, every time a command that performs
-- copy/paste operations is run.
-- To get around this, we use xclip (X11 tool) as an alternative, but this only works
-- well if XWayland is running. Luckily for me, it is running (on Fedora Linux).
if vim.fn.empty(vim.env.WAYLAND_DISPLAY) == 0 and vim.env.DESKTOP_SESSION == "gnome" and vim.fn.executable("xclip") == 1 then
  vim.g.clipboard = {
    name = "xclip",
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
