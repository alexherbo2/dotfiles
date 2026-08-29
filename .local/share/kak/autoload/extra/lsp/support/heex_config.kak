hook global BufSetOption "filetype=heex" %{
  set buffer lsp_servers 'expert = { command = "expert", args = ["--stdio"], root_globs = ["mix.exs"] }'
  set buffer lsp_language_id "heex"
}
