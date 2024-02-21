local wt = require("wezterm")

return {
  -- COLORS
  color_scheme = "carbonfox",
  colors = require("colors"),
  term = "xterm-256color",

  -- CURSOR
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 500,
  default_cursor_style = "BlinkingBlock",

  -- FONT
  font = wt.font({
    family = "FiraCode NF",
    harfbuzz_features = { "liga=1" },
  }),
  font_size = 12,

  -- GUI
  background = {
    {
      source = {
        File = wt.config_dir .. "/backgrounds/bg-1.jpg",
      },
      vertical_align = "Middle",
      horizontal_align = "Center",
      hsb = {
        brightness = 0.1,
      },
    },
  },
  hide_tab_bar_if_only_one_tab = true,
  show_new_tab_button_in_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- KEY BINDINGS
  keys = require("key_bindings"),

  -- SHELL
  default_prog = require("shell"),
}
