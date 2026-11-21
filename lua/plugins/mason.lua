vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
}, { confirm = false })

require("mason").setup()

local ensure_installed = {}

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
