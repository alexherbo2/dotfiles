# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command select_highlights %{
  execute-keys -save-regs 'ab' '"aZ*%s<ret>"bZ"az"b<a-z>a'
}
