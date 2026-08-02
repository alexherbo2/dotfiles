hook global BufSetOption "filetype=zig" %{
  set buffer lsp_servers 'zls = { command = "zls", args = [], root_globs = ["build.zig"] }'
  set buffer lsp_language_id "zig"
}
