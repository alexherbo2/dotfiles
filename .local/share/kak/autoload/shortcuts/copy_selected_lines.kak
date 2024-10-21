# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command copy_selected_lines_down %{
  execute-keys -draft 'xyP'
}

define-command copy_selected_lines_up %{
  execute-keys -draft 'xyp'
}
