hook global BufCreate '\*git_status\*' %{
  set-option buffer filetype git_status
}

hook global BufSetOption filetype=git_status %{
  add-highlighter buffer/git_status ref git_status
  map -docstring 'jump to files' buffer normal <ret> ':git_status_jump_to_files<ret>'
}
