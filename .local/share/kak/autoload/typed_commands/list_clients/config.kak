hook global BufCreate "\*clients\*" %{
  set buffer filetype client_list
}

hook global BufSetOption "filetype=client_list" %{
  add-highlighter buffer/client_list ref client_list
  map -docstring "select whole entries" buffer normal <a-0> ":select_client_list_entries 0<ret>"
  map -docstring "select first field of entries" buffer normal <a-1> ":select_client_list_entries 1<ret>"
  map -docstring "enter command mode with client context" buffer normal <a-:> ":enter_command_mode_with_client_context<ret>"
}
