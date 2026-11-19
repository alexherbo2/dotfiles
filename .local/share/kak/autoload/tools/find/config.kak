hook g BufCreate "\*find\*" %{
  set b filetype find
}

hook g BufSetOption "filetype=find" %{
  addhl b/find ref find
  map -docstring "jump to files" b normal <ret> ":jump_to_files<ret>"
  map -docstring "select whole entries" b normal <a-0> ":select_find_entries 0<ret>"
  map -docstring "select first field of entries" b normal <a-1> ":select_find_entries 1<ret>"
  map -docstring "enter command mode with find context" b normal <a-:> ":enter_command_mode_with_find_context<ret>"
  map -docstring "open selected files in the user’s preferred application" b normal <a-ret> ":enter_command_mode_with_find_context<ret>open --<ret>"
}
