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
    "lazy",
    "Trouble",
    "Outline",
    "TelescopePrompt",
  },
  large_file_cutoff = 100000,
})
