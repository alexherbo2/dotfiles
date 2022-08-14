-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'

return {
  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,

  -- Color scheme
  -- https://wezfurlong.org/wezterm/config/appearance.html
  --
  -- Catppuccin
  -- https://catppuccin.com
  color_scheme = 'Catppuccin Frappe',

  window_background_opacity = 0.99,

  -- Font configuration
  -- https://wezfurlong.org/wezterm/config/fonts.html
  font = wezterm.font('JetBrains Mono'),
  font_size = 16.0,

  -- Disable ligatures
  -- https://wezfurlong.org/wezterm/config/font-shaping.html
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  -- Cursor style
  default_cursor_style = 'BlinkingBar',
}
