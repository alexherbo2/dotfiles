hook global BufSetOption "filetype=javascript" %{
  set buffer lsp_servers 'tsc = { command = "tsc", args = ["--lsp", "--stdio"], root_globs = [".git"] }'
  set buffer lsp_language_id "javascript"
}
