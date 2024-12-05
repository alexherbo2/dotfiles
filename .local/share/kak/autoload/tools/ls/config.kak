hook global BufCreate '\*ls\*' %{
  set-option buffer filetype ls
}

hook global BufSetOption filetype=ls %{
  add-highlighter buffer/ls ref ls
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'jump to files or directories and close ls buffer' buffer normal <s-ret> ':jump_to_files_or_directories_and_close_ls_buffer<ret>'
}
