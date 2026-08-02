hook global BufSetOption "filetype=rust" %{
  set buffer lsp_servers 'rust-analyzer = { command = "rust-analyzer", args = [], root_globs = ["Cargo.toml"] }'
  set buffer lsp_language_id "rust"
}
