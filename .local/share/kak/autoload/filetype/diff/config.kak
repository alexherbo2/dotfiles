# https://en.wikipedia.org/wiki/Diff#Unified_format
hook global BufCreate '.+\.diff' %{
  set-option buffer filetype diff
}

hook global BufSetOption filetype=diff %{
  add-highlighter buffer/diff ref diff
  hook -always -once buffer BufSetOption 'filetype=(?!diff).*' %{
    remove-highlighter buffer/diff
  }
}
