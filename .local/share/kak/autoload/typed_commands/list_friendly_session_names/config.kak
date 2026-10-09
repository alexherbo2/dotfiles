hook global BufCreate "\*friendly_session_names\*" %{
  set-option buffer filetype friendly_session_names
}

hook global BufSetOption "filetype=friendly_session_names" %{
  add-highlighter buffer/friendly_session_names ref friendly_session_names
  map -docstring "rename session" buffer normal <ret> ":rename_session_to_selected_friendly_session_name<ret>"
  map -docstring "select entries" buffer normal <c-ret> ":select_friendly_session_name_entries %%val{count}<ret>"
}
