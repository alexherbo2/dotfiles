hook global BufSetOption "filetype=python" %{
  set buffer lsp_servers 'ty = { command = "ty", args = ["server"], root_globs = [".git"] }'
  set buffer lsp_language_id "python"
}
