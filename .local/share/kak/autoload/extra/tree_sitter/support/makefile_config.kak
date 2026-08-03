hook global BufSetOption "filetype=makefile" %{
  set buffer tree_sitter_lang "make"
}
