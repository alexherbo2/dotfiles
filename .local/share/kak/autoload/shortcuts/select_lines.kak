# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
def -hidden select_whole_lines_or_extend_lines_down %{
  exec '<a-:>'
  try %{
    # At least one selection is not full, so select whole lines.
    exec -draft '<a-K>\A^.*\n\z<ret>'
    exec 'x'
  } catch %{
    exec 'Jx'
  }
}
