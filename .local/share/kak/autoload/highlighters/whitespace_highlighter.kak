set-face global Tab Whitespace
set-face global Newline Whitespace
set-face global NonBreakingSpace Whitespace
set-face global Indent Whitespace
set-face global MixedIndent WhitespaceDiagnosticError
set-face global OddIndent WhitespaceDiagnosticError
set-face global TrailingWhitespace WhitespaceDiagnosticError
set-face global ConsecutiveWhitespace WhitespaceDiagnosticError
set-face global LineLength80 WhitespaceDiagnosticHint

set-face global WhitespaceDiagnosticError DiagnosticError
set-face global WhitespaceDiagnosticWarning DiagnosticWarning
set-face global WhitespaceDiagnosticInfo DiagnosticInfo
set-face global WhitespaceDiagnosticHint DiagnosticHint

add-highlighter shared/whitespace group
add-highlighter shared/whitespace/ regex '\t+' '0:Tab'
add-highlighter shared/whitespace/ regex '\n+' '0:Newline'
add-highlighter shared/whitespace/ regex ' +' '0:NonBreakingSpace'
add-highlighter shared/whitespace/ regex '\h{2,}' '0:ConsecutiveWhitespace'
add-highlighter shared/whitespace/ regex '^\h+' '0:Indent'
add-highlighter shared/whitespace/ regex '\h+$' '0:TrailingWhitespace'
add-highlighter shared/whitespace/ regex '^( {1}| {3}| {5}| {7}| {9}| {11}| {13}| {15}| {17}| {19})(?![*\s])' '0:OddIndent'
add-highlighter shared/whitespace/ regex '^(\t+ | +\t)\h*' '0:MixedIndent'
add-highlighter shared/whitespace/ regex '(?S)^.{79}\K\S$' '0:LineLength80'

hook global ModeChange 'push:normal:insert' %{
  set-face window TrailingWhitespace Whitespace
  set-face window ConsecutiveWhitespace Whitespace
  hook -once window ModeChange 'pop:insert:normal' %{
    unset-face window TrailingWhitespace
    unset-face window ConsecutiveWhitespace
  }
}
