hook global BufCreate '\*find\*' %{
  set-option buffer filetype find
}

hook global BufSetOption filetype=find %{
  add-highlighter buffer/find ref find
  map -docstring 'jump to files' buffer normal <ret> ':jump_to_files<ret>'
  map -docstring 'jump to files and close find buffer' buffer normal <s-ret> ':jump_to_files_and_close_find_buffer<ret>'
}
