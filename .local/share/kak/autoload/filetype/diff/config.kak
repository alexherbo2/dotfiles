# https://en.wikipedia.org/wiki/Diff#Unified_format
add-highlighter shared/diff regions
add-highlighter shared/diff/original_files region '^---' '$' fill comment
add-highlighter shared/diff/new_files region '^\Q+++' '$' fill comment
add-highlighter shared/diff/range_information region '^@@' '$' fill comment
add-highlighter shared/diff/line_additions region '^\+' '$' fill added
add-highlighter shared/diff/line_deletions region '^-' '$' fill deleted
add-highlighter shared/diff/contextual_lines region '^\h' '$' fill text

hook global BufCreate '.+\.diff' %{
  set-option buffer filetype diff
}

hook global BufSetOption filetype=diff %{
  add-highlighter buffer/diff ref diff
  hook -always -once buffer BufSetOption 'filetype=(?!diff).*' %{
    remove-highlighter buffer/diff
  }
}
