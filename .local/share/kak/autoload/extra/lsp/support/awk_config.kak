hook global BufSetOption "filetype=awk" %{
  set buffer lsp_servers 'awk-language-server = { command = "awk-language-server", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "awk"
}
