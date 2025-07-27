vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_config_lsp_attach", { clear = true }),
  callback = function(event)
    local keymaps = {
      ---------------------- Hover & Signature -----------------------
      { "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "Hover Documentation" },
      { "gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, desc = "Signature Help" },

      ---------------------- Goto / Navigation -----------------------
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
      { "gr", vim.lsp.buf.references, desc = "References" },

      ------------------------- Diagnostics --------------------------
      { "gl", vim.diagnostic.open_float, desc = "Show Line Diagnostics" },
      { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next Diagnostic" },
      { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Prev Diagnostic" },
      { "<Leader>lj", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next Diagnostic" },
      { "<Leader>lk", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Prev Diagnostic" },
      { "<Leader>lq", vim.diagnostic.setloclist, desc = "Diagnostics → Loclist" },
      { "<Leader>ld", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<Leader>lD", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },

      -------------------- Code Actions & Lenses ---------------------
      { "<Leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" } },
      { "<Leader>lf", vim.lsp.buf.format, desc = "Format Document" },
      { "<Leader>lr", vim.lsp.buf.rename, desc = "Rename Symbol" },
      { "<Leader>lc", vim.lsp.codelens.run, desc = "Run CodeLens" },

      --------------------- Symbols & Workspace ----------------------
      { "<Leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
      { "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
      { "<Leader>ll", "<Cmd>Trouble lsp toggle focus=false<CR>", desc = "LSP Definitions / References / ... (Trouble)" },

      -------------------------- Misc LSP ----------------------------
      { "<Leader>li", "<Cmd>LspInfo<CR>", desc = "LSP Info" },
      { "<Leader>lR", "<Cmd>LspRestart<CR>", desc = "Restart LSP" },
    }

    for _, map in ipairs(keymaps) do
      local lhs, rhs = map[1], map[2]
      vim.keymap.set(map.mode or "n", lhs, rhs, {
        buffer = event.buf,
        desc = map.desc,
        silent = true,
      })
    end
  end,
})
