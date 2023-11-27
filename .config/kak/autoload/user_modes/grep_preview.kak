declare-user-mode grep_preview

hook global BufSetOption filetype=grep %{
  map -docstring 'enter grep preview mode' buffer goto <ret> '<a-;>:enter_grep_preview_mode<ret>'
}

define-command enter_grep_preview_mode %{
  execute-keys ',;'
  jump_to_references
  enter-user-mode -lock grep_preview
  hook -once window NormalIdle .* %{
    execute-keys 'ga'
  }
}

map -docstring 'next match' global grep_preview j 'gaj:jump_to_references<ret>'
map -docstring 'previous match' global grep_preview k 'gak:jump_to_references<ret>'
