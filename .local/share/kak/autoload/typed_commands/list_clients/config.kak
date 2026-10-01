hook global BufCreate "\*clients\*" %{
  set buffer filetype client_list
}

hook global BufSetOption "filetype=client_list" %{
  add-highlighter buffer/client_list ref client_list
  map -docstring "select entries" buffer normal <c-ret> ":select_client_list_entries %%val{count}<ret>"
  map -docstring "enter command" buffer normal <a-:> ":enter_client_command<ret>"
}
