hook global BufSetOption "filetype=nix" %{
  set buffer lsp_servers 'nil = { command = "nil", args = [], root_globs = ["flake.nix", "shell.nix"] }'
  set buffer lsp_language_id "nix"
}
