hook global BufSetOption "filetype=git_commit" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "git-commit"
}
