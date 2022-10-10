local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
  return
end

local pre_hook_ok, pre_hook = pcall(function()
  return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
end)
if not pre_hook_ok then
  return
end

comment.setup({
  pre_hook = pre_hook,
})
