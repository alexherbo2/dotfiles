# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command move_selected_lines_down %{
  execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'
}

define-command move_selected_lines_up %{
  execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'
}
