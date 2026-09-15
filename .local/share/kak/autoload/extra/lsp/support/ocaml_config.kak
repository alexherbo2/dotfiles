hook global BufSetOption "filetype=ocaml" %{
  set buffer lsp_servers 'ocamllsp = { command = "ocamllsp", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "ocaml"
}
