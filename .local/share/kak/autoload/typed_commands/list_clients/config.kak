hook global BufCreate "\*clients\*" %{
  set buffer filetype client_list
}

hook global BufSetOption "filetype=client_list" %{
  add-highlighter buffer/client_list ref client_list
  map -docstring "select entries" buffer normal <c-ret> ":select_client_list_entries %%val{count}<ret>"
  map -docstring "enter command mode with client context" buffer normal <a-:> ":enter_command_mode_with_client_context<ret>"
}
