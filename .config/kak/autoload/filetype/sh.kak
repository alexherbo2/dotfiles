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

# Creates the base regions
add-highlighter shared/sh regions
add-highlighter shared/sh/code default-region group

# Comments
add-highlighter shared/sh.comment regions
add-highlighter shared/sh.comment/comment default-region group
add-highlighter shared/sh.comment/comment/ fill comment

# Strings
add-highlighter shared/sh.string regions
add-highlighter shared/sh.string/string default-region group
add-highlighter shared/sh.string/string/ fill string

# Interpolated strings
add-highlighter shared/sh.string.interpolated regions
add-highlighter shared/sh.string.interpolated/string default-region group
add-highlighter shared/sh.string.interpolated/string/ fill string
add-highlighter shared/sh.string.interpolated/string/ ref sh.variable
add-highlighter shared/sh.string.interpolated/ region -recurse '\(' '\$\(\K' '(?=\))' ref sh

# Variables
add-highlighter shared/sh.variable regions
add-highlighter shared/sh.variable/variable default-region group
add-highlighter shared/sh.variable/variable/ regex '(?<!\\)(\\\\)*\$\K(\w+|[#@?$!*-])' 0:variable
add-highlighter shared/sh.variable/ region -recurse '\{' '\$\{\K' '(?=\})' fill variable

# Syntax and semantics
add-highlighter shared/sh/code/function_name_declaration regex '^\h*\K\w+(?=\(\))' 0:function
add-highlighter shared/sh/code/variable_name_declaration regex '\b\w+(?==)' 0:variable
add-highlighter shared/sh/code/alias_name_declaration regex '^\h*alias\h*\K[\w.-]+(?==)' 0:variable
add-highlighter shared/sh/code/variable ref sh.variable

# Keywords
# compgen -k
add-highlighter shared/sh/code/keyword regex '\bif\b|\bthen\b|\belse\b|\belif\b|\bfi\b|\bcase\b|\besac\b|\bfor\b|\bselect\b|\bwhile\b|\buntil\b|\bdo\b|\bdone\b|\bin\b|\bfunction\b|\btime\b|\{|\}|!|\[\[|\]\]|\bcoproc\b' 0:keyword

# Built-in functions
# compgen -b
add-highlighter shared/sh/code/builtin regex '\.|:|\[|\balias\b|\bbg\b|\bbind\b|\bbreak\b|\bbuiltin\b|\bcaller\b|\bcd\b|\bcommand\b|\bcompgen\b|\bcomplete\b|\bcompopt\b|\bcontinue\b|\bdeclare\b|\bdirs\b|\bdisown\b|\becho\b|\benable\b|\beval\b|\bexec\b|\bexit\b|\bexport\b|\bfalse\b|\bfc\b|\bfg\b|\bgetopts\b|\bhash\b|\bhelp\b|\bhistory\b|\bjobs\b|\bkill\b|\blet\b|\blocal\b|\blogout\b|\bmapfile\b|\bpopd\b|\bprintf\b|\bpushd\b|\bpwd\b|\bread\b|\breadarray\b|\breadonly\b|\breturn\b|\bset\b|\bshift\b|\bshopt\b|\bsource\b|\bsuspend\b|\btest\b|\btimes\b|\btrap\b|\btrue\b|\btype\b|\btypeset\b|\bulimit\b|\bumask\b|\bunalias\b|\bunset\b|\bwait\b' 0:builtin

# Comments
add-highlighter shared/sh/comment region '(?<!\\)(\\\\)*(^|\h)\K#' '$' ref sh.comment

# Single quoted strings
add-highlighter shared/sh/string.quoted.single region "(?<!\\)(\\\\)*\K'" "'" ref sh.string

# Double quoted strings
add-highlighter shared/sh/string.quoted.double region '(?<!\\)(\\\\)*\K"' '(?<!\\)(\\\\)*"' group
add-highlighter shared/sh/string.quoted.double/escaped regex '\\"' 0:value
add-highlighter shared/sh/string.quoted.double/interpolated ref sh.string.interpolated

# Here document
add-highlighter shared/sh/string.unquoted.heredoc region -match-capture '<<-(\w+)' '^(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.unquoted.heredoc.indent region -match-capture '<<-(\w+)' '^\t*(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.quoted.single.heredoc region -match-capture "<<-'(\w+)'" '^(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.single.heredoc.indent region -match-capture "<<-'(\w+)'" '^\t*(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc region -match-capture '<<-"(\w+)"' '^(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc.indent region -match-capture '<<-"(\w+)"' '^\t*(\w+)$' ref sh.string
