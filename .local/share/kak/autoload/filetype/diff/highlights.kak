# https://en.wikipedia.org/wiki/Diff#Unified_format
add-highlighter shared/diff regions
add-highlighter shared/diff/original_files region '^---' '$' fill deleted
add-highlighter shared/diff/new_files region '^\Q+++' '$' fill added
add-highlighter shared/diff/range_information region '^@@' '$' fill changed
add-highlighter shared/diff/line_additions region '^\+' '$' fill added
add-highlighter shared/diff/line_deletions region '^-' '$' fill deleted
add-highlighter shared/diff/contextual_lines region '^\h' '$' fill text
