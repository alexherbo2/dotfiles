hook global BufSetOption "filetype=zsh" %{
  set buffer lsp_servers 'bash-language-server = { command = "bash-language-server", args = ["start"], root_globs = [".git"] }'
  set buffer lsp_language_id "shellscript"
}
