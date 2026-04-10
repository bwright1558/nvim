local M = {}

M._log = print

-- Paths
---@type string
local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
---@type string
local tmp_dir = (os.getenv("TMPDIR") or "/tmp") .. "/ts-parsers"

--- Run a shell command. Returns true on success, false on failure.
---@param cmd string
---@return boolean
local function run(cmd)
  local ok = os.execute(cmd)
  -- Lua 5.1 returns a number, 5.2+ returns boolean
  if type(ok) == "number" then
    return ok == 0
  end
  return ok == true
end

--- Check if a file exists.
---@param path string
---@return boolean
local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

--- Clone a repo if not already cloned. Returns clone dir or nil on failure.
---@param p ParserEntry
---@return string?
local function clone(p)
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

  M._log("  clone: " .. url .. (p.branch and (" (" .. p.branch .. ")") or ""))
  if not run("git clone --depth 1 --quiet" .. branch_flag .. " " .. url .. " " .. clone_dir) then
    M._log("  FAILED: clone")
    return nil
  end

  return clone_dir
end

--- Resolve the source directory (handles subdir).
---@param clone_dir string
---@param p ParserEntry
---@return string
local function resolve_src_dir(clone_dir, p)
  if p.subdir then
    return clone_dir .. "/" .. p.subdir
  end
  return clone_dir
end

--- Ensure parser.c exists, generating it if necessary. Returns true on success.
---@param src_dir string
---@return boolean
local function ensure_parser_c(src_dir)
  local parser_c = src_dir .. "/src/parser.c"
  if file_exists(parser_c) then
    return true
  end

  M._log("  parser.c not found, running tree-sitter generate...")
  if run("command -v tree-sitter >/dev/null 2>&1") then
    return run("cd " .. src_dir .. " && tree-sitter generate")
  elseif run("command -v npx >/dev/null 2>&1") then
    return run("cd " .. src_dir .. " && npx tree-sitter-cli generate")
  end

  M._log("  FAILED: no parser.c and could not generate it")
  return false
end

--- Collect source files and determine the compiler. Returns srcs list and compiler string.
---@param src_dir string
---@return string[] srcs, string compiler
local function collect_sources(src_dir)
  local srcs = { src_dir .. "/src/parser.c" }
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

  return srcs, compiler
end

--- Compile source files into a parser .so. Returns true on success.
---@param name string
---@param srcs string[]
---@param compiler string
---@param src_dir string
---@return boolean
local function compile(name, srcs, compiler, src_dir)
  local so_path = parser_dir .. "/" .. name .. ".so"

  local filenames = {}
  for _, s in ipairs(srcs) do
    table.insert(filenames, s:match("[^/]+$"))
  end
  M._log("  compile: " .. table.concat(filenames, " "))

  -- stylua: ignore start
  local cmd = compiler
    .. " -shared -o " .. so_path
    .. " -I " .. src_dir .. "/src"
    .. " " .. table.concat(srcs, " ")
    .. " -O2 2>&1"
  -- stylua: ignore end

  if run(cmd) and file_exists(so_path) then
    M._log("  installed: " .. so_path)
    return true
  end

  os.remove(so_path)
  M._log("  FAILED: compile")
  return false
end

--- Check whether a parser .so is already installed.
---@param name string
---@return boolean
function M.is_installed(name)
  return file_exists(parser_dir .. "/" .. name .. ".so")
end

--- Install a single parser. Skips if already installed.
---@param p ParserEntry
---@param force? boolean
---@return boolean
function M.install(p, force)
  if not force and M.is_installed(p.name) then
    M._log("  skip: already installed")
    return true
  end

  local clone_dir = clone(p)
  if not clone_dir then
    return false
  end

  local src_dir = resolve_src_dir(clone_dir, p)

  if not ensure_parser_c(src_dir) then
    return false
  end

  local srcs, compiler = collect_sources(src_dir)
  return compile(p.name, srcs, compiler, src_dir)
end

--- Install all parsers in the given list. Optionally filter by name.
--- Returns a list of failed parser names.
---@param parser_list ParserEntry[]
---@param filter_names? string[]
---@param force? boolean
---@return string[] failed
function M.install_all(parser_list, filter_names, force)
  vim.fn.mkdir(parser_dir, "p")
  vim.fn.mkdir(tmp_dir, "p")

  local filter = {}
  if filter_names and #filter_names > 0 then
    for _, name in ipairs(filter_names) do
      filter[name] = true
    end
  end
  local has_filter = next(filter) ~= nil

  M._log("Parser dir: " .. parser_dir)
  M._log("")

  local failed = {}
  for _, p in ipairs(parser_list) do
    if not has_filter or filter[p.name] then
      M._log("[" .. p.name .. "]")
      if not M.install(p, force) then
        table.insert(failed, p.name)
      end
      M._log("")
    end
  end

  run("rm -rf " .. tmp_dir)
  return failed
end

return M
