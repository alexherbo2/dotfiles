hook global BufSetOption "filetype=makefile" %{
  set buffer lsp_servers 'make-ls = { command = "make-ls", args = [], root_globs = ["Makefile"] }'
  set buffer lsp_language_id "makefile"
}
