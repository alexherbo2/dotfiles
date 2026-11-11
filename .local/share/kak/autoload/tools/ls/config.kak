hook global BufCreate '\*ls\*' %{
  set-option buffer filetype ls
}

hook global BufSetOption 'filetype=ls' %{
  add-highlighter buffer/ls ref ls
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'select whole entries' buffer normal <a-0> ':select_ls_entries 0<ret>'
  map -docstring 'select first field of entries' buffer normal <a-1> ':select_ls_entries 1<ret>'
  map -docstring "enter command mode with ls context" buffer normal <a-:> ":enter_command_mode_with_ls_context<ret>"
}
