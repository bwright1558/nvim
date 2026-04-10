---@class ParserEntry
---@field name string
---@field repo string
---@field subdir? string
---@field branch? string

local M = {
  -- core nvim / docs / queries
  { name = "vim", repo = "tree-sitter-grammars/tree-sitter-vim" },
  { name = "vimdoc", repo = "neovim/tree-sitter-vimdoc" },
  { name = "query", repo = "tree-sitter-grammars/tree-sitter-query" },
  { name = "comment", repo = "stsewd/tree-sitter-comment" },
  { name = "markdown", repo = "tree-sitter-grammars/tree-sitter-markdown", subdir = "tree-sitter-markdown" },
  { name = "markdown_inline", repo = "tree-sitter-grammars/tree-sitter-markdown", subdir = "tree-sitter-markdown-inline" },

  -- shells / config
  { name = "bash", repo = "tree-sitter/tree-sitter-bash" },
  { name = "fish", repo = "ram02z/tree-sitter-fish" },
  { name = "tmux", repo = "Freed-Wu/tree-sitter-tmux" },
  { name = "ssh_config", repo = "tree-sitter-grammars/tree-sitter-ssh-config" },
  { name = "dockerfile", repo = "camdencheek/tree-sitter-dockerfile" },
  { name = "git_config", repo = "the-mikedavis/tree-sitter-git-config" },
  { name = "git_rebase", repo = "the-mikedavis/tree-sitter-git-rebase" },
  { name = "gitattributes", repo = "tree-sitter-grammars/tree-sitter-gitattributes" },
  { name = "gitcommit", repo = "gbprod/tree-sitter-gitcommit" },
  { name = "gitignore", repo = "shunsambongi/tree-sitter-gitignore" },
  { name = "json", repo = "tree-sitter/tree-sitter-json" },
  { name = "json5", repo = "Joakker/tree-sitter-json5" },
  { name = "toml", repo = "tree-sitter-grammars/tree-sitter-toml" },
  { name = "yaml", repo = "tree-sitter-grammars/tree-sitter-yaml" },
  { name = "hcl", repo = "tree-sitter-grammars/tree-sitter-hcl" },
  { name = "terraform", repo = "tree-sitter-grammars/tree-sitter-hcl", subdir = "dialects/terraform" },

  -- common programming
  { name = "c", repo = "tree-sitter/tree-sitter-c" },
  { name = "cpp", repo = "tree-sitter/tree-sitter-cpp" },
  { name = "go", repo = "tree-sitter/tree-sitter-go" },
  { name = "gomod", repo = "camdencheek/tree-sitter-go-mod" },
  { name = "gosum", repo = "tree-sitter-grammars/tree-sitter-go-sum" },
  { name = "gowork", repo = "omertuc/tree-sitter-go-work" },
  { name = "python", repo = "tree-sitter/tree-sitter-python" },
  { name = "rust", repo = "tree-sitter/tree-sitter-rust" },
  { name = "lua", repo = "tree-sitter-grammars/tree-sitter-lua" },

  -- web
  { name = "html", repo = "tree-sitter/tree-sitter-html" },
  { name = "css", repo = "tree-sitter/tree-sitter-css" },
  { name = "scss", repo = "serenadeai/tree-sitter-scss" },
  { name = "javascript", repo = "tree-sitter/tree-sitter-javascript" },
  { name = "jsdoc", repo = "tree-sitter/tree-sitter-jsdoc" },
  { name = "typescript", repo = "tree-sitter/tree-sitter-typescript", subdir = "typescript" },
  { name = "tsx", repo = "tree-sitter/tree-sitter-typescript", subdir = "tsx" },
  { name = "graphql", repo = "bkegley/tree-sitter-graphql" },

  -- misc common
  { name = "diff", repo = "tree-sitter-grammars/tree-sitter-diff" },
  { name = "http", repo = "rest-nvim/tree-sitter-http" },
  { name = "jq", repo = "flurie/tree-sitter-jq" },
  { name = "just", repo = "IndianBoy42/tree-sitter-just" },
  { name = "make", repo = "tree-sitter-grammars/tree-sitter-make" },
  { name = "proto", repo = "coder3101/tree-sitter-proto" },
  { name = "regex", repo = "tree-sitter/tree-sitter-regex" },
  { name = "sql", repo = "derekstride/tree-sitter-sql", branch = "gh-pages" },
  { name = "xml", repo = "tree-sitter-grammars/tree-sitter-xml", subdir = "xml" },

  -- other
  { name = "latex", repo = "latex-lsp/tree-sitter-latex" },
  { name = "svelte", repo = "tree-sitter-grammars/tree-sitter-svelte" },
  { name = "typst", repo = "uben0/tree-sitter-typst" },
  { name = "vue", repo = "tree-sitter-grammars/tree-sitter-vue" },
}

return M
