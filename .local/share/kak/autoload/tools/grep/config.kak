hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption 'filetype=grep' %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer normal <ret> ':jump_to_references<ret>'
  map -docstring 'select entries' buffer normal <c-ret> ':select_grep_entries %val{count}<ret>'
}
