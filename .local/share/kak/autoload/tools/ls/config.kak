hook g BufCreate "\*ls\*" %{
  set b filetype ls
}

hook g BufSetOption "filetype=ls" %{
  addhl b/ls ref ls
  map -docstring "jump to files or directories" b normal <ret> ":jump_to_files_or_directories<ret>"
  map -docstring "select whole entries" b normal <a-0> ":select_ls_entries 0<ret>"
  map -docstring "select first field of entries" b normal <a-1> ":select_ls_entries 1<ret>"
  map -docstring "enter command mode with ls context" b normal <a-:> ":enter_command_mode_with_ls_context<ret>"
  map -docstring "open selected files in the user’s preferred application" b normal <a-ret> ":enter_command_mode_with_ls_context<ret>open --<ret>"
  map -docstring "copy selected files as pathnames" b normal <a-y> ":enter_command_mode_with_ls_context<ret>reg %%sh{echo ""${kak_register:-\""}""}<ret>"
}
