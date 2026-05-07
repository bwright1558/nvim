vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user_plugin_treesitter_build", { clear = true }),
  desc = "Handle nvim-treesitter updates",
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/folke/ts-comments.nvim",
}, { confirm = false })

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

local ts = require("nvim-treesitter")
ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Fix markdown_inline messing with `${var}` rendering in Golang hover documentation
-- This disables markdown_inline injections
vim.treesitter.query.set("markdown_inline", "injections", "")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_plugin_treesitter_start", { clear = true }),
  pattern = ts_filetypes,
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end

    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.schedule(function()
  ts.install(ts_parsers)

  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })
end)
