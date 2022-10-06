local command = vim.api.nvim_create_user_command

command("TrimWhitespace", "%s/\\s\\+$//e", {})
command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", {})
command("Format", vim.lsp.buf.formatting_seq_sync, {})
