# Window

# Modes ────────────────────────────────────────────────────────────────────────

try %[ declare-user-mode window ]

define-command -override window-mode -docstring 'window mode' %{
  enter-user-mode window
}

# Mappings ─────────────────────────────────────────────────────────────────────

# Window mode
map -docstring 'window mode' global normal <c-w> ': window-mode<ret>'

# Window commands
map -docstring 'new client' global window n ': terminal kak -c %val{session}<ret>'
map -docstring 'horizontal split' global window h ': terminal-horizontal kak -c %val{session}<ret>'
map -docstring 'vertical split' global window v ': terminal-vertical kak -c %val{session}<ret>'
map -docstring 'new tab' global window t ': terminal-tab kak -c %val{session}<ret>'
map -docstring 'new window' global window w ': terminal-window kak -c %val{session}<ret>'
map -docstring 'close client' global window q ': quit<ret>'

# Window viewport
map -docstring 'grab buffer in viewport (0)' global goto 0 '<esc>:swap-window client0<ret>'
map -docstring 'grab buffer in viewport (1)' global goto 1 '<esc>:swap-window client1<ret>'
map -docstring 'grab buffer in viewport (2)' global goto 2 '<esc>:swap-window client2<ret>'
map -docstring 'grab buffer in viewport (3)' global goto 3 '<esc>:swap-window client3<ret>'
map -docstring 'grab buffer in viewport (4)' global goto 4 '<esc>:swap-window client4<ret>'
map -docstring 'grab buffer in viewport (5)' global goto 5 '<esc>:swap-window client5<ret>'
map -docstring 'grab buffer in viewport (6)' global goto 6 '<esc>:swap-window client6<ret>'
map -docstring 'grab buffer in viewport (7)' global goto 7 '<esc>:swap-window client7<ret>'
map -docstring 'grab buffer in viewport (8)' global goto 8 '<esc>:swap-window client8<ret>'
map -docstring 'grab buffer in viewport (9)' global goto 9 '<esc>:swap-window client9<ret>'

# Commands ─────────────────────────────────────────────────────────────────────

define-command -override link-window -params 1 -client-completion -docstring 'link-window <client>: link window to client' %{
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"sz'
}

define-command -override move-window -params 1 -client-completion -docstring 'move-window <client>: move window to client' %{
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"sz'
  buffer-next
}

define-command -override swap-window -params 1 -client-completion -docstring 'swap-window <client>: swap window with client' %{
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"tZ'
  execute-keys '"tz'
  execute-keys -client %arg{1} '"sz'
}
