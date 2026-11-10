hook global BufCreate '\*buffers\*' %{
  set-option buffer filetype buffer_list
}

hook global BufSetOption 'filetype=buffer_list' %{
  add-highlighter buffer/buffer_list ref buffer_list
  map -docstring 'jump to buffers' buffer normal <ret> ':jump_to_buffers<ret>'
  map -docstring 'select entries' buffer normal <a-0> ':select_buffer_list_entries 0<ret>'
  map -docstring 'select entries (field 1)' buffer normal <a-1> ':select_buffer_list_entries 1<ret>'
  map -docstring 'select entries (field 2)' buffer normal <a-2> ':select_buffer_list_entries 2<ret>'
  map -docstring 'enter command mode with buffer context' buffer normal <a-:> ':enter_command_mode_with_buffer_context<ret>'
}
