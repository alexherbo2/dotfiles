hook global BufSetOption "filetype=common-lisp" %{
  set buffer lsp_servers 'cl-lsp = { command = "cl-lsp", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "common-lisp"
}
