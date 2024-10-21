# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command select_whole_lines_or_extend_lines_down %{
  execute-keys '<a-:>'
  try %{
    # At least one selection is not full, so select whole lines.
    execute-keys -draft '<a-K>\A^.*\n\z<ret>'
    execute-keys 'x'
  } catch %{
    execute-keys 'Jx'
  }
}
