-- Install treesitter parsers from source.
--
-- Usage:
--   From CLI:    nvim -l scripts/install-parsers.lua [parser_name ...]
--   From Neovim: :luafile scripts/install-parsers.lua
--
-- If no arguments, installs all parsers.
-- Skips parsers that are already installed.

local parsers = {
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

-- Paths
local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
local tmp_dir = (os.getenv("TMPDIR") or "/tmp") .. "/ts-parsers"

--- Run a shell command. Returns true on success, false on failure.
local function run(cmd)
  local ok = os.execute(cmd)
  -- Lua 5.1 returns a number, 5.2+ returns boolean
  if type(ok) == "number" then
    return ok == 0
  end
  return ok == true
end

--- Check if a file exists.
local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

--- Clone a repo if not already cloned. Returns the clone directory.
local function ensure_cloned(p)
  local repo_name = p.repo:match("[^/]+$")
  local dir_suffix = p.branch and (repo_name .. "-" .. p.branch) or repo_name
  local clone_dir = tmp_dir .. "/" .. dir_suffix

  if file_exists(clone_dir .. "/.git/HEAD") then
    return clone_dir
  end

  local url = "https://github.com/" .. p.repo
  local branch_flag = ""
  if p.branch then
    branch_flag = " --branch " .. p.branch
  end

  print("  clone: " .. url .. (p.branch and (" (" .. p.branch .. ")") or ""))
  if not run("git clone --depth 1 --quiet" .. branch_flag .. " " .. url .. " " .. clone_dir) then
    print("  FAILED: clone")
    return nil
  end

  return clone_dir
end

--- Compile and install a single parser.
local function install_parser(p)
  local so_path = parser_dir .. "/" .. p.name .. ".so"

  if file_exists(so_path) then
    print("  skip: already installed")
    return true
  end

  local clone_dir = ensure_cloned(p)
  if not clone_dir then
    return false
  end

  local src_dir = clone_dir
  if p.subdir then
    src_dir = clone_dir .. "/" .. p.subdir
  end

  local parser_c = src_dir .. "/src/parser.c"

  -- Generate parser.c if missing
  if not file_exists(parser_c) then
    print("  parser.c not found, running tree-sitter generate...")
    local generated = false
    if run("command -v tree-sitter >/dev/null 2>&1") then
      generated = run("cd " .. src_dir .. " && tree-sitter generate")
    elseif run("command -v npx >/dev/null 2>&1") then
      generated = run("cd " .. src_dir .. " && npx tree-sitter-cli generate")
    end
    if not generated then
      print("  FAILED: no parser.c and could not generate it")
      return false
    end
  end

  -- Build source list
  local srcs = { parser_c }
  local compiler = "cc"

  local scanner_c = src_dir .. "/src/scanner.c"
  if file_exists(scanner_c) then
    table.insert(srcs, scanner_c)
  end

  local scanner_cc = src_dir .. "/src/scanner.cc"
  if file_exists(scanner_cc) then
    table.insert(srcs, scanner_cc)
    compiler = "c++"
  end

  -- Show what we're compiling
  local filenames = {}
  for _, s in ipairs(srcs) do
    table.insert(filenames, s:match("[^/]+$"))
  end
  print("  compile: " .. table.concat(filenames, " "))

  local cmd = compiler .. " -shared -o " .. so_path .. " -I " .. src_dir .. "/src" .. " " .. table.concat(srcs, " ") .. " -O2 2>&1"

  if run(cmd) and file_exists(so_path) then
    print("  installed: " .. so_path)
    return true
  else
    os.remove(so_path)
    print("  FAILED: compile")
    return false
  end
end

-- Main

vim.fn.mkdir(parser_dir, "p")
vim.fn.mkdir(tmp_dir, "p")

-- Collect requested parsers from command-line args
local requested = {}
for _, a in ipairs(arg or {}) do
  requested[a] = true
end
local filter = next(requested) ~= nil

print("Parser dir: " .. parser_dir)
print("")

local failed = {}

for _, p in ipairs(parsers) do
  if not filter or requested[p.name] then
    print("[" .. p.name .. "]")
    if not install_parser(p) then
      table.insert(failed, p.name)
    end
    print("")
  end
end

-- Clean up
run("rm -rf " .. tmp_dir)

if #failed > 0 then
  print("Failed: " .. table.concat(failed, ", "))
else
  print("Done.")
end
