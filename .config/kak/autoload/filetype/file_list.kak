# syntax "**/*.file_list"
# syntax keywords "^{%a}:[/\\]{%w/\\%._-}|^{%w/\\%._-}"
# syntax symbols ":|,|-|%(|%)"
# syntax literals "%d{%d}"

add-highlighter shared/file_list regex '^(.+?)$' 0:value

hook global BufOpenFifo '.+\.file_list' %{
  set-option buffer filetype file_list
}

hook -group grep-highlight global BufSetOption filetype=file_list %{
  add-highlighter buffer/file_list ref file_list
  map buffer normal <ret> ':jump_to_files<ret>'
}

define-command -hidden jump_to_files %{
  execute-keys 'x<a-s>_gf'
}
