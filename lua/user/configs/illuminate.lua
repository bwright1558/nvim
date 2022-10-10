local ok, illuminate = pcall(require, "illuminate")
if not ok then
  return
end

illuminate.configure({
  delay = 250,
  filetypes_denylist = {
    "dirbuf",
    "dirvish",
    "fugitive",
    "NvimTree",
    "packer",
    "Trouble",
    "Outline",
    "TelescopePrompt",
  },
})
