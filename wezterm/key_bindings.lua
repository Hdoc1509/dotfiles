local wt = require("wezterm")

local act = wt.action
local act_cb = wt.action_callback

return {
  -- SPLITS
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  -- SCROLL
  { key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
  { key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
  { key = "End", mods = "SHIFT", action = act.ScrollToBottom },
  { key = "Home", mods = "SHIFT", action = act.ScrollToTop },

  -- FULLSCREEN
  { key = "F11", action = act.ToggleFullScreen },

  -- TABS
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
