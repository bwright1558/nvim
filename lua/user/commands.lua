local command = vim.api.nvim_create_user_command

command("TrimWhitespace", "%s/\\s\\+$//e", { desc = "Trim trailing whitespace" })
command("TrimNewlines", "%s/\\($\\n\\s*\\)\\+\\%$//e", { desc = "Trim trailing newlines" })
command("Format", vim.lsp.buf.formatting_seq_sync, { desc = "Format current buffer with LSP" }) -- XXX: Maybe put in lsp on_attach function?
