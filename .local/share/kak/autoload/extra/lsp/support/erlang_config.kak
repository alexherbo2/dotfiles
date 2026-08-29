hook global BufSetOption "filetype=erlang" %{
  set buffer lsp_servers 'elp = { command = "elp", args = ["server"], root_globs = [".git"] }'
  set buffer lsp_language_id "erlang"
}
