-- treesitter.lua
--
-- Plugin configuration for nvim-treesitter.
-- Provides incremental parsing and syntax-aware features
-- like highlighting, indentation, folding, etc.
--
-- See: https://github.com/nvim-treesitter/nvim-treesitter

local ts_parsers = {
  -- core nvim / docs / queries
  "vim",
  "vimdoc",
  "query",
  "comment",
  "markdown",
  "markdown_inline",

  -- shells / config
  "bash",
  "fish",
  "tmux",
  "ssh_config",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "json",
  "json5",
  "toml",
  "yaml",
  "hcl",
  "terraform",

  -- common programming
  "c",
  "cpp",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "python",
  "rust",
  "lua",

  -- web
  "html",
  "css",
  "scss",
  "javascript",
  "jsdoc",
  "typescript",
  "tsx",
  "graphql",

  -- misc common
  "diff",
  "http",
  "jq",
  "just",
  "make",
  "proto",
  "regex",
  "sql",
  "xml",

  -- other
  "latex",
  "svelte",
  "typst",
  "vue",
}

local ts_filetypes = {
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "fish",
  "gitattributes",
  "gitcommit",
  "gitconfig",
  "gitignore",
  "gitrebase",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "graphql",
  "hcl",
  "help",
  "html",
  "http",
  "javascript",
  "javascriptreact",
  "jq",
  "js",
  "json",
  "json5",
  "jsonc",
  "jsx",
  "just",
  "lua",
  "make",
  "markdown",
  "pandoc",
  "proto",
  "python",
  "query",
  "rust",
  "scss",
  "sh",
  "sql",
  "sshconfig",
  "svelte",
  "terraform",
  "terraform-vars",
  "tex",
  "tmux",
  "toml",
  "ts",
  "typ",
  "typescript",
  "typescript.tsx",
  "typescriptreact",
  "typst",
  "vim",
  "vue",
  "xml",
  "xsd",
  "xslt",
  "svg",
  "yaml",
}

local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    install_dir = vim.fn.stdpath("data") .. "/site",
  },
  config = function(_, opts)
    local treesitter = require("nvim-treesitter")
    treesitter.setup(opts)
    treesitter.install(ts_parsers)

    -- Fix markdown_inline messing with `${var}` rendering in Golang hover documentation
    -- This disables markdown_inline injections
    vim.treesitter.query.set("markdown_inline", "injections", "")

    local group = vim.api.nvim_create_augroup("user_config_treesitter_start", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = ts_filetypes,
      callback = function()
        if vim.bo.buftype ~= "" then
          return
        end

        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

return M
