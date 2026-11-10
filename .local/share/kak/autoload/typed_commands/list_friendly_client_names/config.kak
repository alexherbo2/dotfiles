hook global BufCreate "\*friendly_client_names\*" %{
  set-option buffer filetype friendly_client_names
}

hook global BufSetOption "filetype=friendly_client_names" %{
  add-highlighter buffer/friendly_client_names ref friendly_client_names
  map -docstring "rename client" buffer normal <ret> ":rename_client_to_selected_friendly_client_name<ret>"
  map -docstring "select entries" buffer normal <a-0> ":select_friendly_client_name_entries 0<ret>"
  map -docstring "select entries (field 1)" buffer normal <a-1> ":select_friendly_client_name_entries 1<ret>"
}
