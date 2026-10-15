hook global BufCreate '\*sessions\*' %{
  set-option buffer filetype session_list
}

hook global BufSetOption 'filetype=session_list' %{
  add-highlighter buffer/session_list ref session_list
  map -docstring 'select entries' buffer normal <c-ret> ':select_session_list_entries %val{count}<ret>'
  map -docstring 'enter command mode with session context' buffer normal <a-:> ':enter_command_mode_with_session_context<ret>'
}
