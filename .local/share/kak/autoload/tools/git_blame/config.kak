hook global BufCreate '\*git_blame\*' %{
  set buffer filetype git_blame
}

hook global BufSetOption 'filetype=git_blame' %{
  addhl buffer/git_blame ref git_blame
  map -docstring 'show patches' buffer normal <ret> ':git_blame_show_patches<ret>'
  map -docstring 'select whole entries' buffer normal <a-0> ':select_git_blame_entries 0<ret>'
  map -docstring 'select first field of entries' buffer normal <a-1> ':select_git_blame_entries 1<ret>'
  map -docstring 'select second field of entries' buffer normal <a-2> ':select_git_blame_entries 2<ret>'
  map -docstring 'select third field of entries' buffer normal <a-3> ':select_git_blame_entries 3<ret>'
  map -docstring 'select fourth field of entries' buffer normal <a-4> ':select_git_blame_entries 4<ret>'
}
