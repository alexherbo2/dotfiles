hook global BufSetOption "filetype=git_config" %{
  set buffer lsp_servers ''
  set buffer lsp_language_id "git-config"
}
