hook global BufCreate '\*git_blame\*' %{
  set buffer filetype git_blame
}

hook global BufSetOption 'filetype=git_blame' %{
  addhl buffer/git_blame ref git_blame
  map -docstring 'show patches' buffer normal <ret> ':git_blame_show_patches<ret>'
  map -docstring 'select entries' buffer normal <a-0> ':select_git_blame_entries 0<ret>'
  map -docstring 'select entries (field 1)' buffer normal <a-1> ':select_git_blame_entries 1<ret>'
  map -docstring 'select entries (field 2)' buffer normal <a-2> ':select_git_blame_entries 2<ret>'
  map -docstring 'select entries (field 3)' buffer normal <a-3> ':select_git_blame_entries 3<ret>'
  map -docstring 'select entries (field 4)' buffer normal <a-4> ':select_git_blame_entries 4<ret>'
}
