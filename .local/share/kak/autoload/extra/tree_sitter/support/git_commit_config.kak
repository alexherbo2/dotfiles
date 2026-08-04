hook global BufSetOption "filetype=git_commit" %{
  set buffer tree_sitter_lang "git-commit"
}
