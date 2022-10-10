local b = {
  tl = "┌", -- top left
  tr = "┐", -- top right

  bl = "└", -- bottom left
  br = "┘", -- bottom right

  v = "│", -- vertical
  h = "─", -- horizontal

  s = "█", -- scroll
}

return {
  style = "single",
  bqf = { b.v, b.v, b.h, b.h, b.tl, b.tr, b.bl, b.br, b.s },
  telescope = { b.h, b.v, b.h, b.v, b.tl, b.tr, b.br, b.bl },
}
