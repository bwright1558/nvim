local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",

    -- Snippets
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- Autopairs integration
    "windwp/nvim-autopairs",
  },
}

function M.config()
  require("luasnip.loaders.from_vscode").lazy_load()

  local luasnip = require("luasnip")
  local icons = require("user.icons")
  local border = require("user.borders").style

  -- Used by nvim-cmp to override the completion menu popups.
  -- FloatBorder is removed to leave it as the default.
  -- Default: "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"
  -- NOTE: This is related to the theme. So maybe consider defining this in theme.lua.
  local winhighlight = "Normal:NormalFloat,CursorLine:Visual,Search:None"

  local source_names = {
    nvim_lsp = "(LSP)",
    path = "(Path)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
  }
  local duplicates = {
    nvim_lsp = 0,
    path = 1,
    luasnip = 1,
    buffer = 1,
  }

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp = require("cmp")
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    experimental = {
      ghost_text = true,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = source_names[entry.source.name]
        vim_item.dup = duplicates[entry.source.name] or 0

        local max_width = 80
        if #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
        end

        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered({
        border = border,
        winhighlight = winhighlight,
      }),
      documentation = cmp.config.window.bordered({
        border = border,
        winhighlight = winhighlight,
      }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer" },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),

      ["<C-y>"] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
  })

  local on_confirm_done = require("nvim-autopairs.completion.cmp").on_confirm_done()
  cmp.event:on("confirm_done", on_confirm_done)
end

return M
