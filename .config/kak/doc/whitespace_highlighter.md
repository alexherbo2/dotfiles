Example configuration:

```
add-highlighter global/whitespace ref whitespace

set-face global Whitespace 'bright-black+fa'
set-face global WhitespaceDiagnosticError ',,red+c'
set-face global WhitespaceDiagnosticWarning ',,yellow+c'
set-face global WhitespaceDiagnosticInfo ',,blue+c'
set-face global WhitespaceDiagnosticHint ',,green+u'

set-face global Tab WhitespaceDiagnosticError
set-face global Newline Whitespace
set-face global NonBreakingSpace WhitespaceDiagnosticError
set-face global Indent Whitespace
```
