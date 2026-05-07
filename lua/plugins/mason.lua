vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
}, { confirm = false })

vim.schedule(function()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
end)

local ensure_installed = {
  -- LSPs
  "bash-language-server",
  "css-lsp",
  "dockerfile-language-server",
  "fish-lsp",
  "golangci-lint-langserver",
  "gopls",
  "graphql-language-service-cli",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "pyright",
  "rust-analyzer",
  "sqlls",
  "taplo", -- LSP + formatter
  "typescript-language-server",
  "vim-language-server",
  "yaml-language-server",
  "zls",

  -- Formatters
  "gofumpt",
  "goimports",
  "isort",
  "ruff",
  "prettierd",
  "stylua",
  "shfmt",
}

-- Ensure tools are installed
vim.defer_fn(function()
  local registry = require("mason-registry")

  registry.refresh(function()
    for _, tool in ipairs(ensure_installed) do
      local package = registry.get_package(tool)
      if not package:is_installed() and not package:is_installing() then
        vim.notify(("[mason.nvim] installing %s"):format(tool), vim.log.levels.INFO)

        package:install():once("closed", function()
          vim.schedule(function()
            vim.notify(("[mason.nvim] %s was successfully installed"):format(tool), vim.log.levels.INFO)
          end)
        end)
      end
    end
  end)
end, 3000)
