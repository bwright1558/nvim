#!/usr/bin/env bash
#
# Install treesitter parsers from source.
# Usage: ./install-parsers.sh [parser_name ...]
# If no arguments, installs all parsers.

set -euo pipefail

PARSER_DIR="${HOME}/.local/share/nvim/site/parser"
TMPDIR="${TMPDIR:-/tmp}/ts-parsers"

mkdir -p "$PARSER_DIR"
mkdir -p "$TMPDIR"

# Format: name|repo|subdir|branch (-- = default)
PARSERS="
vim|https://github.com/tree-sitter-grammars/tree-sitter-vim|--|--
vimdoc|https://github.com/neovim/tree-sitter-vimdoc|--|--
query|https://github.com/tree-sitter-grammars/tree-sitter-query|--|--
comment|https://github.com/stsewd/tree-sitter-comment|--|--
markdown|https://github.com/tree-sitter-grammars/tree-sitter-markdown|tree-sitter-markdown|--
markdown_inline|https://github.com/tree-sitter-grammars/tree-sitter-markdown|tree-sitter-markdown-inline|--
bash|https://github.com/tree-sitter/tree-sitter-bash|--|--
fish|https://github.com/ram02z/tree-sitter-fish|--|--
tmux|https://github.com/Freed-Wu/tree-sitter-tmux|--|--
ssh_config|https://github.com/tree-sitter-grammars/tree-sitter-ssh-config|--|--
dockerfile|https://github.com/camdencheek/tree-sitter-dockerfile|--|--
git_config|https://github.com/the-mikedavis/tree-sitter-git-config|--|--
git_rebase|https://github.com/the-mikedavis/tree-sitter-git-rebase|--|--
gitattributes|https://github.com/tree-sitter-grammars/tree-sitter-gitattributes|--|--
gitcommit|https://github.com/gbprod/tree-sitter-gitcommit|--|--
gitignore|https://github.com/shunsambongi/tree-sitter-gitignore|--|--
json|https://github.com/tree-sitter/tree-sitter-json|--|--
json5|https://github.com/Joakker/tree-sitter-json5|--|--
toml|https://github.com/tree-sitter-grammars/tree-sitter-toml|--|--
yaml|https://github.com/tree-sitter-grammars/tree-sitter-yaml|--|--
hcl|https://github.com/tree-sitter-grammars/tree-sitter-hcl|--|--
terraform|https://github.com/tree-sitter-grammars/tree-sitter-hcl|dialects/terraform|--
c|https://github.com/tree-sitter/tree-sitter-c|--|--
cpp|https://github.com/tree-sitter/tree-sitter-cpp|--|--
go|https://github.com/tree-sitter/tree-sitter-go|--|--
gomod|https://github.com/camdencheek/tree-sitter-go-mod|--|--
gosum|https://github.com/tree-sitter-grammars/tree-sitter-go-sum|--|--
gowork|https://github.com/omertuc/tree-sitter-go-work|--|--
python|https://github.com/tree-sitter/tree-sitter-python|--|--
rust|https://github.com/tree-sitter/tree-sitter-rust|--|--
lua|https://github.com/tree-sitter-grammars/tree-sitter-lua|--|--
html|https://github.com/tree-sitter/tree-sitter-html|--|--
css|https://github.com/tree-sitter/tree-sitter-css|--|--
scss|https://github.com/serenadeai/tree-sitter-scss|--|--
javascript|https://github.com/tree-sitter/tree-sitter-javascript|--|--
jsdoc|https://github.com/tree-sitter/tree-sitter-jsdoc|--|--
typescript|https://github.com/tree-sitter/tree-sitter-typescript|typescript|--
tsx|https://github.com/tree-sitter/tree-sitter-typescript|tsx|--
graphql|https://github.com/bkegley/tree-sitter-graphql|--|--
diff|https://github.com/tree-sitter-grammars/tree-sitter-diff|--|--
http|https://github.com/rest-nvim/tree-sitter-http|--|--
jq|https://github.com/flurie/tree-sitter-jq|--|--
just|https://github.com/IndianBoy42/tree-sitter-just|--|--
make|https://github.com/tree-sitter-grammars/tree-sitter-make|--|--
proto|https://github.com/coder3101/tree-sitter-proto|--|--
regex|https://github.com/tree-sitter/tree-sitter-regex|--|--
sql|https://github.com/derekstride/tree-sitter-sql|--|gh-pages
xml|https://github.com/tree-sitter-grammars/tree-sitter-xml|xml|--
latex|https://github.com/latex-lsp/tree-sitter-latex|--|--
svelte|https://github.com/tree-sitter-grammars/tree-sitter-svelte|--|--
typst|https://github.com/uben0/tree-sitter-typst|--|--
vue|https://github.com/tree-sitter-grammars/tree-sitter-vue|--|--
"

compile_parser() {
  local name="$1"
  local repo="$2"
  local subdir="$3"
  local branch="$4"

  if [ -f "$PARSER_DIR/${name}.so" ]; then
    echo "  skip: ${name}.so already exists"
    return 0
  fi

  local repo_name
  repo_name=$(basename "$repo")
  local clone_dir="$TMPDIR/$repo_name"
  # Use a separate clone dir when a non-default branch is needed
  if [ "$branch" != "--" ]; then
    clone_dir="$TMPDIR/${repo_name}-${branch}"
  fi

  # Clone only if not already cloned (repos can be shared, e.g. typescript/tsx)
  if [ ! -d "$clone_dir" ]; then
    echo "  clone: $repo${branch:+ (branch: $branch)}"
    local clone_args=(--depth 1 --quiet)
    if [ "$branch" != "--" ]; then
      clone_args+=(--branch "$branch")
    fi
    git clone "${clone_args[@]}" "$repo" "$clone_dir"
  fi

  local src_dir="$clone_dir"
  if [ "$subdir" != "--" ]; then
    src_dir="$clone_dir/$subdir"
  fi

  # Generate parser.c if missing (requires tree-sitter CLI or npx)
  if [ ! -f "$src_dir/src/parser.c" ]; then
    echo "  parser.c not found, running tree-sitter generate..."
    if command -v tree-sitter &>/dev/null; then
      (cd "$src_dir" && tree-sitter generate)
    elif command -v npx &>/dev/null; then
      (cd "$src_dir" && npx tree-sitter-cli generate)
    else
      echo "  SKIP: no parser.c and neither tree-sitter nor npx available"
      return 1
    fi
  fi

  local srcs=("$src_dir/src/parser.c")
  if [ -f "$src_dir/src/scanner.c" ]; then
    srcs+=("$src_dir/src/scanner.c")
  fi

  local compiler="cc"
  if [ -f "$src_dir/src/scanner.cc" ]; then
    srcs+=("$src_dir/src/scanner.cc")
    compiler="c++"
  fi

  echo "  compile: ${srcs[*]##*/}"
  if $compiler -shared -o "$PARSER_DIR/${name}.so" -I "$src_dir/src" "${srcs[@]}" -O2 2>&1; then
    echo "  installed: $PARSER_DIR/${name}.so"
  else
    rm -f "$PARSER_DIR/${name}.so"
    echo "  FAILED to compile ${name}"
    return 1
  fi
}

# Determine which parsers to install
requested=("$@")

echo "Parser dir: $PARSER_DIR"
echo ""

while IFS='|' read -r name repo subdir branch; do
  [ -z "$name" ] && continue

  # If specific parsers requested, skip others
  if [ ${#requested[@]} -gt 0 ]; then
    skip=true
    for r in "${requested[@]}"; do
      if [ "$r" = "$name" ]; then
        skip=false
        break
      fi
    done
    $skip && continue
  fi

  echo "[$name]"
  compile_parser "$name" "$repo" "$subdir" "$branch" || true
  echo ""
done <<< "$PARSERS"

# Clean up
rm -rf "$TMPDIR"

echo "Done."
