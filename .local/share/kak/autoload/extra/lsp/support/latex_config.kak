hook global BufSetOption "filetype=latex" %{
  set buffer lsp_servers 'texlab = { command = "texlab", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "latex"
}
