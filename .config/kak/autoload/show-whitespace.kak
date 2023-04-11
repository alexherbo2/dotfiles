# Refined show whitespace

# Faces ────────────────────────────────────────────────────────────────────────

# Whitespace characters:
set-face global Tab WhitespaceError
set-face global Newline Whitespace
set-face global NonBreakingSpace WhitespaceError

# Indentation rules:
set-face global Indent Whitespace
set-face global MixedIndent WhitespaceError
set-face global OddIndent WhitespaceError

# Extra whitespace:
set-face global TrailingWhitespace WhitespaceError
set-face global ConsecutiveWhitespace WhitespaceWarning

# Generic faces:
set-face global WhitespaceRuler 'green+fu'
set-face global WhitespaceError 'red+fc'
set-face global WhitespaceWarning 'red+fc'

# Hooks ────────────────────────────────────────────────────────────────────────

# Only shown when not in insert mode.
remove-hooks global whitespace
hook -group whitespace -always global ModeChange 'push:normal:insert' %{
  set-face window TrailingWhitespace Whitespace
  set-face window ConsecutiveWhitespace Whitespace

  # Restore
  hook -always -once window ModeChange 'pop:insert:normal' %{
    unset-face window TrailingWhitespace
    unset-face window ConsecutiveWhitespace
  }
}

# Highlighters ─────────────────────────────────────────────────────────────────

# Order matters:
#
# “You can think of highlighters as like a list of painting instructions.” — Screwtape
#
add-highlighter -override shared/whitespace group

# Show whitespace (tabs, newlines, non-breaking-spaces).
add-highlighter -override shared/whitespace/tab regex '\t+' '0:Tab'
add-highlighter -override shared/whitespace/newline regex '\n+' '0:Newline'
add-highlighter -override shared/whitespace/non-breaking-space regex ' +' '0:NonBreakingSpace'

# Show consecutive whitespace, then paint over indent.
add-highlighter -override shared/whitespace/consecutive-whitespace regex '\h{2,}' '0:ConsecutiveWhitespace'
add-highlighter -override shared/whitespace/indent regex '^\h+' '0:Indent'

# Show trailing whitespace.
add-highlighter -override shared/whitespace/trailing-whitespace regex '\h+$' '0:TrailingWhitespace'

# Show odd and mixed indent.
add-highlighter -override shared/whitespace/odd-indent regex '^( {1}| {3}| {5}| {7}| {9}| {11}| {13}| {15}| {17}| {19})(?=\H)' '0:OddIndent'
add-highlighter -override shared/whitespace/mixed-indent regex '^(\t+ | +\t)\h*' '0:MixedIndent'

# Show limit of 80 characters.
add-highlighter -override shared/whitespace/ruler regex '(?S)^.{80}$\K\n' '0:WhitespaceRuler'
