hook global BufCreate '\*git_blame\*' %{
  set-option buffer filetype git_blame
}

hook global BufSetOption filetype=git_blame %{
  add-highlighter buffer/git_blame ref git_blame
  map -docstring 'show patches' buffer normal <ret> ':git_blame_show_patches<ret>'
}
