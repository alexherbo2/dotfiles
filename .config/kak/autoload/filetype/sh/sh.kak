# This script provides support for POSIX shells.
# https://gnu.org/software/bash/manual/bash.html

hook global BufCreate '.+\.sh' %{
  set-option buffer filetype sh
}

hook global BufSetOption filetype=sh %{
  add-highlighter buffer/sh ref sh
  set-option buffer increase_indent_pattern '[({\[]$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$'
  set-option buffer ignore_indent_pattern '^\h*#'
  set-option buffer line_comment_token '#'
  set-option buffer static_words 'if' 'then' 'else' 'elif' 'fi' 'case' 'esac' 'for' 'select' 'while' 'until' 'do' 'done' 'in' 'function' 'time' '{' '}' '!' '[[' ']]' 'coproc' '.' ':' '[' 'alias' 'bg' 'bind' 'break' 'builtin' 'caller' 'cd' 'command' 'compgen' 'complete' 'compopt' 'continue' 'declare' 'dirs' 'disown' 'echo' 'enable' 'eval' 'exec' 'exit' 'export' 'false' 'fc' 'fg' 'getopts' 'hash' 'help' 'history' 'jobs' 'kill' 'let' 'local' 'logout' 'mapfile' 'popd' 'printf' 'pushd' 'pwd' 'read' 'readarray' 'readonly' 'return' 'set' 'shift' 'shopt' 'source' 'suspend' 'test' 'times' 'trap' 'true' 'type' 'typeset' 'ulimit' 'umask' 'unalias' 'unset' 'wait'
  hook -always -once buffer BufSetOption 'filetype=(?!sh).*' %{
    remove-highlighter buffer/sh
  }
}
