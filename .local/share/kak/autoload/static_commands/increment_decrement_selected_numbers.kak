# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command -hidden increment_selected_numbers -params 1 %{
  execute-keys "a+%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}

define-command -hidden decrement_selected_numbers -params 1 %{
  execute-keys "a-%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}
