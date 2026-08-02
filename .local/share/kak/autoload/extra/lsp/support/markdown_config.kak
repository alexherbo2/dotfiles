hook global BufSetOption "filetype=markdown" %{
  set buffer lsp_servers 'marksman = { command = "marksman", args = ["server"], root_globs = [".git"] }'
  set buffer lsp_language_id "markdown"
}
