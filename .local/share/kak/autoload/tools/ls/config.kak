hook g BufCreate "\*ls\*" %{
  set b filetype ls
}

hook g BufSetOption "filetype=ls" %{
  addhl b/ls ref ls
  map -docstring "jump to files or directories" buffer normal <ret> ":jump_to_files_or_directories<ret>"
  map -docstring "select whole entries" buffer normal <a-0> ":select_ls_entries 0<ret>"
  map -docstring "select first field of entries" buffer normal <a-1> ":select_ls_entries 1<ret>"
  map -docstring "enter command mode with ls context" buffer normal <a-:> ":enter_command_mode_with_ls_context<ret>"
  map -docstring "open selected files in the user’s preferred application" buffer normal <a-ret> ":enter_command_mode_with_ls_context<ret>open --<ret>"
}
