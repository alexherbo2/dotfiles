-- Hammerspoon
-- https://hammerspoon.org
--
-- Keys: https://github.com/Hammerspoon/hammerspoon/blob/master/extensions/keycodes/libkeycodes.m

-- Uses Karabiner-Elements to convert your caps lock to the hyper key: "⌘" + "⌃" + "⌥" + "⇧".
-- https://karabiner-elements.pqrs.org
local hyper = { "cmd", "ctrl", "alt", "shift" }

-- Simple logger for debugging purposes.
local log = hs.logger.new("Hammerspoon", "debug")

hs.hotkey.bind(hyper, "return", function()
  log.i("Alacritty")
  hs.application.launchOrFocus("Alacritty")
end)

hs.hotkey.bind(hyper, "m", function()
  log.i("mpv")
  hs.application.launchOrFocus("mpv")
end)

hs.hotkey.bind(hyper, "y", function()
  log.i("mpv - youtube-dl")
  hs.execute("pbpaste | mpv -playlist -")
end)

hs.hotkey.bind(hyper, "w", function()
  log.i("Google Chrome")
  hs.application.launchOrFocus("Google Chrome")
end)

-- Hints mode
hs.hotkey.bind(hyper, "f", function()
  log.i("Hints mode")
  hs.hints.windowHints()
end)

-- Move focused window to screen number.
local function moveFocusedWindowToScreenNumber(number)
  local function()
    local screens = hs.screen.allScreens()
    local window = hs.window.focusedWindow()
    window:moveToScreen(screens[number])
  end
end

-- Move focused window to screen number.
hs.hotkey.bind(hyper, "1", moveFocusedWindowToScreenNumber(1))
hs.hotkey.bind(hyper, "2", moveFocusedWindowToScreenNumber(2))
hs.hotkey.bind(hyper, "3", moveFocusedWindowToScreenNumber(3))
hs.hotkey.bind(hyper, "4", moveFocusedWindowToScreenNumber(4))
hs.hotkey.bind(hyper, "5", moveFocusedWindowToScreenNumber(5))
hs.hotkey.bind(hyper, "6", moveFocusedWindowToScreenNumber(6))
hs.hotkey.bind(hyper, "7", moveFocusedWindowToScreenNumber(7))
hs.hotkey.bind(hyper, "8", moveFocusedWindowToScreenNumber(8))
hs.hotkey.bind(hyper, "9", moveFocusedWindowToScreenNumber(9))
