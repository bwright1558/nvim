local command = vim.api.nvim_create_user_command

command("TrimWhitespace", "%s/\\s\\+$//e", { desc = "Trim trailing whitespace" })
command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", { desc = "Trim trailing newlines" })
command("Format", function() vim.lsp.buf.format() end, { desc = "Format" })

local winsplit = require("user.winsplit")
command("FocusSplitLeft", function() winsplit.focus("h") end, { desc = "Focus split left" })
command("FocusSplitDown", function() winsplit.focus("j") end, { desc = "Focus split down" })
command("FocusSplitUp", function() winsplit.focus("k") end, { desc = "Focus split up" })
command("FocusSplitRight", function() winsplit.focus("l") end, { desc = "Focus split right" })
