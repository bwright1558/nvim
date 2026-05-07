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
    -- stylua: ignore start
    local keymap_specs = {
      -- Hover & Signature
      { "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, desc = "Hover documentation" },
      { "gK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, desc = "Signature help" },

      -- Goto / Navigation
      { "gd", vim.lsp.buf.definition, desc = "Goto definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "Goto implementation" },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto type definition" },
      { "gr", vim.lsp.buf.references, desc = "References" },

      -- Diagnostics
      { "gl", vim.diagnostic.open_float, desc = "Show line diagnostics" },
      { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
      { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
      { "<Leader>lj", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
      { "<Leader>lk", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
      { "<Leader>lq", vim.diagnostic.setloclist, desc = "Diagnostics to location list" },
      { "<Leader>lQ", vim.diagnostic.setqflist, desc = "Diagnostics to quickfix list" },
      { "<Leader>ld", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
      { "<Leader>lD", function() Snacks.picker.diagnostics() end, desc = "Workspace diagnostics" },

      -- Code Actions & Lenses
      { "<Leader>la", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "x" } },
      { "<Leader>lr", vim.lsp.buf.rename, desc = "Rename symbol" },
      { "<Leader>lc", vim.lsp.codelens.run, desc = "Run CodeLens" },
      { "<Leader>lf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format document (conform)" },
      {
        "<Leader>lf",
        function()
          require("conform").format({
            range = {
              start = vim.api.nvim_buf_get_mark(0, "<"),
              ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
            },
            async = true,
            lsp_format = "fallback",
          })
        end,
        desc = "Format selection (conform)",
        mode = { "x" },
      },

      -- Symbols & Workspace
      { "<Leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
      { "<Leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },

      -- Misc LSP
      { "<Leader>li", "<Cmd>LspInfo<CR>", desc = "LSP info" },
      { "<Leader>lR", "<Cmd>LspRestart<CR>", desc = "Restart LSP" },
    }
    -- stylua: ignore end

    local keymaps = require("utils.keymaps")
    keymaps.register(keymap_specs, { buffer = event.buf })
  end,
})
