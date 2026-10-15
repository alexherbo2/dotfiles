hook global BufCreate '\*buffers\*' %{
  set-option buffer filetype buffer_list
}

hook global BufSetOption 'filetype=buffer_list' %{
  add-highlighter buffer/buffer_list ref buffer_list
  map -docstring 'jump to buffers' buffer normal <ret> ':jump_to_buffers<ret>'
  map -docstring 'select entries' buffer normal <c-ret> ':select_buffer_list_entries %val{count}<ret>'
  map -docstring 'enter command mode with buffer context' buffer normal <a-:> ':enter_command_mode_with_buffer_context<ret>'
}
