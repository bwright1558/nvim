local ok, pretty_fold = pcall(require, "pretty-fold")
if not ok then
  return
end

pretty_fold.setup({
  keep_indentation = false,
  fill_char = "━",
  sections = {
    left = {
      "━ ", function() return string.rep("•", vim.v.foldlevel) end, " ━┫", "content", "┣",
    },
    right = {
      "┫ ", "number_of_folded_lines", ": ", "percentage", " ┣━━",
    },
  },
})
