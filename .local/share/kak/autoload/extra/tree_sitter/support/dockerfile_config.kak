hook global BufSetOption "filetype=dockerfile" %{
  set buffer tree_sitter_lang "dockerfile"
}
