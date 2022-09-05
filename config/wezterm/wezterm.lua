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

  -- Leader key
  -- https://wezfurlong.org/wezterm/config/keys.html#leader-key
  leader = { key = '`', timeout_milliseconds = 9000 },

  -- Key bindings
  -- https://wezfurlong.org/wezterm/config/keys.html
  keys = {
    -- Send "`" to the terminal when pressing "`", "`".
    { key = '`', mods="LEADER", action=wezterm.action{SendString='`'} },
    { key = 'o', mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
    { key = 'O', mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    { key = 'c', mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"} },
    { key = 'h', mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"} },
    { key = 'l', mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"} },
    { key = 'k', mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"} },
    { key = 'j', mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"} },
    { key = 'f', mods="LEADER", action="TogglePaneZoomState" },
    { key = 'v', mods="LEADER", action="ActivateCopyMode" },
    { key = '1', mods="LEADER", action=wezterm.action{ActivateTab=0} },
    { key = '2', mods="LEADER", action=wezterm.action{ActivateTab=1} },
    { key = '3', mods="LEADER", action=wezterm.action{ActivateTab=2} },
    { key = '4', mods="LEADER", action=wezterm.action{ActivateTab=3} },
    { key = '5', mods="LEADER", action=wezterm.action{ActivateTab=4} },
    { key = '6', mods="LEADER", action=wezterm.action{ActivateTab=5} },
    { key = '7', mods="LEADER", action=wezterm.action{ActivateTab=6} },
    { key = '8', mods="LEADER", action=wezterm.action{ActivateTab=7} },
    { key = '9', mods="LEADER", action=wezterm.action{ActivateTab=-1} },
    { key = 'n', mods="LEADER", action=wezterm.action{ActivateTabRelative=1} },
    { key = 'p', mods="LEADER", action=wezterm.action{ActivateTabRelative=-1} },
    { key = 'N', mods="LEADER", action=wezterm.action{MoveTabRelative=1} },
    { key = 'P', mods="LEADER", action=wezterm.action{MoveTabRelative=-1} },
  }
}
