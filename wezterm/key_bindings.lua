local act = require("wezterm").action

return {
  -- Split horizontally
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  -- Split vertically
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  -- Scroll up 1 line
  { key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },

  -- Scroll down 1 line
  { key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },

  -- Scrool to bottom
  { key = "End", mods = "SHIFT", action = act.ScrollToBottom },

  -- Scrool to top
  { key = "Home", mods = "SHIFT", action = act.ScrollToTop },

  -- Toggle fullscreen
  { key = "F11", action = act.ToggleFullScreen },
}
