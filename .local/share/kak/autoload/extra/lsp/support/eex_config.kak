hook global BufSetOption "filetype=eex" %{
  set buffer lsp_servers 'expert = { command = "expert", args = ["--stdio"], root_globs = ["mix.exs"] }'
  set buffer lsp_language_id "eex"
}
