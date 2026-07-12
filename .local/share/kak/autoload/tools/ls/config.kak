def -docstring '
command: ls [dir]
kakoune_options: []
' ls -params 0..1 %{
  ls_impl %arg{@}
}

complete-command ls file

hook global BufCreate '\*ls\*' %{
  set-option buffer filetype ls
}

hook global BufSetOption 'filetype=ls' %{
  add-highlighter buffer/ls ref ls
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'select entries' buffer normal <c-ret> ':select_ls_entries %val{count}<ret>'
}
