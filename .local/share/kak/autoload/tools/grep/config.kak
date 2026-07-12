decl -docstring '
grep_command = "grep"
' str grep_command 'grep'

decl -docstring '
grep_args = ["-R", "-H", "-n"]
' str-list grep_args '-R' '-H' '-n'

def -docstring '
command: grep [options] [pattern] [paths]
kakoune_options: ["grep_command", "grep_args"]
' grep -params .. %{
  grep_impl %arg{@}
}

complete-command grep file

hook global BufCreate '\*grep\*' %{
  set-option buffer filetype grep
}

hook global BufSetOption 'filetype=grep' %{
  add-highlighter buffer/grep ref grep
  map -docstring 'jump to references' buffer normal <ret> ':jump_to_references<ret>'
  map -docstring 'select references' buffer normal <c-ret> ':select_references<ret>'
}
