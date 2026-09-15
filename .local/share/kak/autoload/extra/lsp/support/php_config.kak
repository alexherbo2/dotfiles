hook global BufSetOption "filetype=php" %{
  set buffer lsp_servers 'intelephense = { command = "intelephense", args = ["--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "php"
}
