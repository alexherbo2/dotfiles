set-face global DiffText 'comment'
set-face global DiffHeader 'comment'
set-face global DiffInserted 'green'
set-face global DiffDeleted 'red'
set-face global DiffChanged 'yellow'

# https://en.wikipedia.org/wiki/Diff#Unified_format
add-highlighter shared/diff regions
add-highlighter shared/diff/original_files region '^---' '$' fill DiffHeader
add-highlighter shared/diff/new_files region '^\Q+++' '$' fill DiffHeader
add-highlighter shared/diff/range_information region '^@@' '$' fill DiffHeader
add-highlighter shared/diff/line_additions region '^\+' '$' fill DiffInserted
add-highlighter shared/diff/line_deletions region '^-' '$' fill DiffDeleted
add-highlighter shared/diff/contextual_lines region '^\h' '$' fill DiffText

hook global BufCreate '.+\.diff' %{
  set-option buffer filetype diff
}

hook global BufSetOption filetype=diff %{
  add-highlighter buffer/diff ref diff
  hook -always -once buffer BufSetOption 'filetype=(?!diff).*' %{
    remove-highlighter buffer/diff
  }
}
