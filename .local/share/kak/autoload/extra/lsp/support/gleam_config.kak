hook global BufSetOption "filetype=gleam" %{
  set buffer lsp_servers 'gleam = { command = "gleam", args = ["lsp"], root_globs = ["gleam.toml"] }'
  set buffer lsp_language_id "gleam"
}
