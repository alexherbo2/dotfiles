hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption filetype=grep %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer normal <ret> ':jump_to_references<ret>'
}
