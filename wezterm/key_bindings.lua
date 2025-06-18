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

  -- URL
  {
    key = "p",
    mods = "CTRL",
    action = act.QuickSelectArgs({
      label = "open url",
      patterns = {
        'https?://[^\\s)"]+',
      },
      action = act_cb(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wt.open_with(url)
      end),
    }),
  },

  -- PANES
  {
    key = "s",
    mods = "ALT",
    action = act.PaneSelect({ mode = "SwapWithActive" }),
  },
  {
    key = "s",
    mods = "CTRL | ALT",
    action = act.PaneSelect({ mode = "MoveToNewTab" }),
  },
}
