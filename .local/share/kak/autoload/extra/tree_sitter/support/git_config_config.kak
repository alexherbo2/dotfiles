hook global BufSetOption "filetype=git_config" %{
  set buffer tree_sitter_lang "git-config"
}
