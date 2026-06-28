# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
def -hidden copy_selected_lines_down -params 1 %{
  exec -draft "xy%arg{1}P"
}

def -hidden copy_selected_lines_up -params 1 %{
  exec -draft "xy%arg{1}p"
}
