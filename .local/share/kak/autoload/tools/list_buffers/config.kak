hook global BufCreate '\*buffers\*' %{
  set-option buffer filetype buffer_list
}

hook global BufSetOption filetype=buffer_list %{
  add-highlighter buffer/buffer_list ref buffer_list
  map -docstring 'jump to buffers' buffer normal <ret> ':jump_to_buffers<ret>'
  map -docstring 'jump to buffers and close buffer_list buffer' buffer normal <s-ret> ':jump_to_buffers_and_close_buffer_list_buffer<ret>'
}
