local auto_install = require("config.treesitter.auto_install")
local highlight = require("config.treesitter.highlight")
local install = require("config.treesitter.install")
local parsers = require("config.treesitter.parsers")

auto_install.run(parsers)
highlight.enable({
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
})

-- :TSInstall [name ...] - install missing parsers (or specific ones)
vim.api.nvim_create_user_command("TSInstall", function(opts)
  local args = #opts.fargs > 0 and opts.fargs or nil
  local failed = install.install_all(parsers, args)
  if #failed > 0 then
    vim.notify("Failed: " .. table.concat(failed, ", "), vim.log.levels.WARN)
  end
end, {
  nargs = "*",
  desc = "Install missing treesitter parsers",
})

-- :TSUpdate [name ...] - force reinstall all parsers (or specific ones)
vim.api.nvim_create_user_command("TSUpdate", function(opts)
  local args = #opts.fargs > 0 and opts.fargs or nil
  local failed = install.install_all(parsers, args, true)
  if #failed > 0 then
    vim.notify("Failed: " .. table.concat(failed, ", "), vim.log.levels.WARN)
  end
end, {
  nargs = "*",
  desc = "Update (force reinstall) treesitter parsers",
})
