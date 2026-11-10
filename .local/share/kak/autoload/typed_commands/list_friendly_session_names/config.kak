hook global BufCreate "\*friendly_session_names\*" %{
  set-option buffer filetype friendly_session_names
}

hook global BufSetOption "filetype=friendly_session_names" %{
  add-highlighter buffer/friendly_session_names ref friendly_session_names
  map -docstring "rename session" buffer normal <ret> ":rename_session_to_selected_friendly_session_name<ret>"
  map -docstring "select entries" buffer normal <a-0> ":select_friendly_session_name_entries 0<ret>"
  map -docstring "select entries (field 1)" buffer normal <a-1> ":select_friendly_session_name_entries 1<ret>"
}
