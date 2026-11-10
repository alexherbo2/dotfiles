hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption 'filetype=grep' %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer normal <ret> ':jump_to_references<ret>'
  map -docstring 'select entries' buffer normal <a-0> ':select_grep_entries 0<ret>'
  map -docstring 'select entries (field 1)' buffer normal <a-1> ':select_grep_entries 1<ret>'
  map -docstring 'select entries (field 2)' buffer normal <a-2> ':select_grep_entries 2<ret>'
  map -docstring 'select entries (field 3)' buffer normal <a-3> ':select_grep_entries 3<ret>'
}
