declare-user-mode grep_preview

hook global BufSetOption filetype=grep %{
  map -docstring 'enter grep preview mode' buffer goto <ret> '<a-;>:enter_grep_preview_mode<ret>'
}

define-command enter_grep_preview_mode %{
  send_handshake_to_jump_client
  execute-keys ',;gh'
  enter-user-mode -lock grep_preview
}

map -docstring 'next match' global grep_preview j 'j:jump_to_references %opt{jump_client}<ret>'
map -docstring 'previous match' global grep_preview k 'k:jump_to_references %opt{jump_client}<ret>'
