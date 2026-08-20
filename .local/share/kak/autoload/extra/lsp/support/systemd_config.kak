hook global BufSetOption "filetype=systemd" %{
  set buffer lsp_servers 'systemd-lsp = { command = "systemd-lsp", args = [], root_globs = [".git"] }'
  set buffer lsp_language_id "systemd"
}
