hook global BufCreate '\*find\*' %{
  set-option buffer filetype find
}

hook global BufSetOption 'filetype=find' %{
  add-highlighter buffer/find ref find
  map -docstring 'jump to files' buffer normal <ret> ':jump_to_files<ret>'
  map -docstring 'select entries' buffer normal <c-ret> ':select_find_entries %val{count}<ret>'
}
