# TODO

- [ ] Revisit `vim.pack` lazy-loaded plugins that show as inactive in `:checkhealth vim.pack`.
      Consider registering intentional lazy plugins early with `vim.pack.add(..., { load = function() end })`,
      then using `vim.cmd.packadd` inside the real event/filetype trigger so stale unused plugins remain visible in health checks.
