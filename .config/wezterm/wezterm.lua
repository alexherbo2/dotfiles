-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'

return {
  -- General -------------------------------------------------------------------

  switch_to_last_active_tab_when_closing_tab = true,

  -- Appearance ----------------------------------------------------------------

  -- Smart tab bar [distraction-free mode]
  hide_tab_bar_if_only_one_tab = true,

  -- Color scheme
  color_scheme = 'Catppuccin Latte',

  -- Add a bit of transparency to reduce eye strain.
  window_background_opacity = 0.99,

  -- Font configuration
  font = wezterm.font('JetBrains Mono'),
  font_size = 16.0,

  -- Cursor style
  default_cursor_style = 'BlinkingBar',

  -- Key bindings --------------------------------------------------------------

  -- Leader key
  leader = { key = [[`]], timeout_milliseconds = 9000 },

  -- Key bindings
  keys = {
    -- Send keys
    { key = [[`]], mods = 'LEADER', action = wezterm.action.SendString [[`]] },

    -- Clipboard
    { key = 'v', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

    -- Zoom
    { key = 'f', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },

    -- Create tabs
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'C', mods = 'LEADER', action = wezterm.action.SpawnCommandInNewTab { cwd = wezterm.home_dir } },

    -- Split panes
    { key = 'o', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'O', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- Focus panes
    { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },

    -- Switch tabs
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'LEADER', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'LEADER', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'LEADER', action = wezterm.action.ActivateTab(-1) },

    -- Move tabs
    { key = 'N', mods = 'LEADER', action = wezterm.action.MoveTabRelative(1) },
    { key = 'P', mods = 'LEADER', action = wezterm.action.MoveTabRelative(-1) },
  }
}
