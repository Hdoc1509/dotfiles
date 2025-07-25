local COLORS = {
  white = "#e8e8e8",
}

return {
  cursor_bg = "#01b8ff",
  cursor_border = "#01b8ff",
  background = "#000000",
  foreground = COLORS.white,
  ansi = {
    "#000000", -- black
    "#fe0100", -- red
    "#00a600", -- green
    "#feff00", -- yellow
    "#0066ff", -- blue
    "#cc00ff", -- magenta
    "#00d5d5", -- cyan
    COLORS.white, -- white
  },
  brights = {
    "#808080", -- bright-black
    "#fe0100", -- bright-red
    "#29cc00", -- bright-green
    "#feff00", -- bright-yellow
    "#0066ff", -- bright-blue
    "#cc00ff", -- bright-magenta
    "#00d5d5", -- bright-cyan
    COLORS.white, -- bright-white
  },
  split = "#01b8ff",
}
