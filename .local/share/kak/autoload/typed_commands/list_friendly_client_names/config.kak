hook global BufCreate "\*friendly_client_names\*" %{
  set-option buffer filetype friendly_client_names
}

hook global BufSetOption "filetype=friendly_client_names" %{
  add-highlighter buffer/friendly_client_names ref friendly_client_names
  map -docstring "rename client" buffer normal <ret> ":rename_client_to_selected_friendly_client_name<ret>"
  map -docstring "select entries" buffer normal <c-ret> ":select_friendly_client_name_entries %%val{count}<ret>"
}
