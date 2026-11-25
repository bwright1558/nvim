-- Update installed treesitter parsers when plugin is updated
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user_plugin_treesitter_build", { clear = true }),
  desc = "Handle nvim-treesitter updates",
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    -- Run TSUpdate after treesitter install/update
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end
      vim.cmd.TSUpdate()
    end
  end,
})

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
}, { confirm = false })

-- Fix markdown_inline messing with `${var}` rendering in Golang hover documentation
-- This disables markdown_inline injections.
--
-- TODO: Is this still needed?
vim.treesitter.query.set("markdown_inline", "injections", "")

-- TODO: Consider putting this in `ftplugin/<filetype>.lua`
--       Or adding `pattern = { '<filetype>' },` to the autocmd.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_plugin_treesitter_start", { clear = true }),
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Schedule treesitter parser installation to avoid slowing down startup
vim.schedule(function()
  require("nvim-treesitter").install({
    "bash",
    "c",
    "c_sharp",
    "comment",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "graphql",
    "hcl",
    "html",
    "http",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "just",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "proto",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "scss",
    "sql",
    "ssh_config",
    "svelte",
    "swift",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
    "zsh",
  })
end)
