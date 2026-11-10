hook global BufCreate '\*git_status\*' %{
  set-option buffer filetype git_status
}

hook global BufSetOption 'filetype=git_status' %{
  add-highlighter buffer/git_status ref git_status
  map -docstring 'jump to files' buffer normal <ret> ':git_status_jump_to_files<ret>'
  map -docstring 'select entries' buffer normal <a-0> ':select_git_status_entries 0<ret>'
  map -docstring 'select entries (field 1)' buffer normal <a-1> ':select_git_status_entries 1<ret>'
  map -docstring 'select entries (field 2)' buffer normal <a-2> ':select_git_status_entries 2<ret>'
}
