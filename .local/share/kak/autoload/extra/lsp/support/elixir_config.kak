hook global BufSetOption "filetype=elixir" %{
  set buffer lsp_servers 'elixir-ls = { command = "elixir-ls", args = [], root_globs = ["mix.exs"] }'
  set buffer lsp_language_id "elixir"
}
