# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
def -hidden move_selected_lines_down -params 1 %{
  exec -draft "x<a-_><a-:>Z;ez%arg{1}J<a-;>JxdzP"
}

def -hidden move_selected_lines_up -params 1 %{
  exec -draft "x<a-_><a-:><a-;>Z;bz%arg{1}K<a-;>Kxdzp"
}
