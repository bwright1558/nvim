local ok, tabnine = pcall(require, "cmp_tabnine.config")
if not ok then
  return
end

tabnine:setup()
