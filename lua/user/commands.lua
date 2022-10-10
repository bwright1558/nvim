local command = vim.api.nvim_create_user_command

command("TrimWhitespace", "%s/\\s\\+$//e", { desc = "Trim trailing whitespace" })
command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", { desc = "Trim trailing newlines" })
command("Format", function() vim.lsp.buf.format() end, { desc = "Format" })
