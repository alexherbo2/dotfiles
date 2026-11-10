hook global BufCreate '\*sessions\*' %{
  set-option buffer filetype session_list
}

hook global BufSetOption 'filetype=session_list' %{
  add-highlighter buffer/session_list ref session_list
  map -docstring 'select entries' buffer normal <a-0> ':select_session_list_entries 0<ret>'
  map -docstring 'select entries (field 1)' buffer normal <a-1> ':select_session_list_entries 1<ret>'
  map -docstring 'enter command mode with session context' buffer normal <a-:> ':enter_command_mode_with_session_context<ret>'
}
