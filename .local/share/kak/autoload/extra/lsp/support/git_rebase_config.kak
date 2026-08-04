hook global BufSetOption "filetype=git_rebase" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "git-rebase"
}
