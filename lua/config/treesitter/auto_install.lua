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

  local total = #missing
  local installed = 0
  local config_dir = vim.fn.stdpath("config")

  local names = table.concat(missing, '","')
  local expr = string.format(
    table.concat({
      'io.stdout:setvbuf("line")',
      'local install = require("config.treesitter.install")',
      'install._log = function(msg) io.write(msg .. "\\n") end',
      'install.install_all(require("config.treesitter.parsers"), {"%s"})',
    }, "; "),
    names
  )

  vim.notify("treesitter: installing " .. total .. " parser(s)...", vim.log.levels.INFO)

  vim.system({ "nvim", "--headless", "--clean", "-c", "set rtp+=" .. config_dir, "-c", "lua " .. expr, "-c", "qa!" }, {
    text = true,
    stdout = function(_, data)
      if not data then
        return
      end
      for line in data:gmatch("[^\n]+") do
        if line:match("^%s+installed:") then
          installed = installed + 1
          vim.schedule(function()
            vim.notify(string.format("treesitter: installed (%d/%d)", installed, total), vim.log.levels.INFO)
          end)
        elseif line:match("^%s+FAILED") then
          local context = line
          vim.schedule(function()
            vim.notify("treesitter: " .. context, vim.log.levels.WARN)
          end)
        end
      end
    end,
  }, function(result)
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
