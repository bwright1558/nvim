local install = require("config.treesitter.install")

local M = {}

---@param parsers ParserEntry[]
function M.run(parsers)
  local missing = {}
  for _, p in ipairs(parsers) do
    if not install.is_installed(p.name) then
      table.insert(missing, p.name)
    end
  end

  if #missing == 0 then
    return
  end

  local names = table.concat(missing, '","')
  local expr = string.format('require("config.treesitter.install").install_all(require("config.treesitter.parsers"), {"%s"})', names)

  vim.notify("treesitter: installing " .. #missing .. " missing parser(s)...", vim.log.levels.INFO)

  local config_dir = vim.fn.stdpath("config")
  vim.system({ "nvim", "--headless", "--clean", "-c", "set rtp+=" .. config_dir, "-c", "lua " .. expr, "-c", "qa!" }, { text = true }, function(result)
    vim.schedule(function()
      if result.code == 0 then
        vim.notify("treesitter: installed " .. #missing .. " parser(s)", vim.log.levels.INFO)
      else
        vim.notify("treesitter: some parsers failed to install", vim.log.levels.WARN)
      end
    end)
  end)
end

return M
