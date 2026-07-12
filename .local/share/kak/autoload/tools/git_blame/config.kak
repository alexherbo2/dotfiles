hook global BufCreate '\*git_blame\*' %{
  set buffer filetype git_blame
}

hook global BufSetOption filetype=git_blame %{
  addhl buffer/git_blame ref git_blame
  map -docstring 'show patches' buffer normal <ret> ':git_blame_show_patches<ret>'
  map -docstring 'select logspecs' buffer normal <c-ret> ':select_logspecs %val{count}<ret>'
}
