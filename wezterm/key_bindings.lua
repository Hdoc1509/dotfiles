local wt = require("wezterm")

local act = wt.action
local act_cb = wt.action_callback

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

  -- Change tab title
  {
    key = "e",
    mods = "CTRL|SHIFT",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = act_cb(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}
