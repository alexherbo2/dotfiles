# sh
# https://gnu.org/software/bash/manual/bash.html

# Configuration ────────────────────────────────────────────────────────────────

# Detection ────────────────────────────────────────────────────────────────────

# Sets sh filetype when opening `.sh` files.
hook global BufCreate '.+\.sh' %{
  set-option buffer filetype sh
}

# Enables syntax highlighting for sh filetype.
# Configures word selection and completion for sh filetype.
hook global BufSetOption filetype=sh %{
  add-highlighter buffer/sh ref sh
  set-option buffer increase_indent_pattern '[({\[]$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$'
  set-option buffer ignore_indent_pattern '^\h*#'
  set-option buffer line_comment_token '#'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option buffer static_words 'if' 'then' 'else' 'elif' 'fi' 'case' 'esac' 'for' 'select' 'while' 'until' 'do' 'done' 'in' 'function' 'time' '{' '}' '!' '[[' ']]' 'coproc' '.' ':' '[' 'alias' 'bg' 'bind' 'break' 'builtin' 'caller' 'cd' 'command' 'compgen' 'complete' 'compopt' 'continue' 'declare' 'dirs' 'disown' 'echo' 'enable' 'eval' 'exec' 'exit' 'export' 'false' 'fc' 'fg' 'getopts' 'hash' 'help' 'history' 'jobs' 'kill' 'let' 'local' 'logout' 'mapfile' 'popd' 'printf' 'pushd' 'pwd' 'read' 'readarray' 'readonly' 'return' 'set' 'shift' 'shopt' 'source' 'suspend' 'test' 'times' 'trap' 'true' 'type' 'typeset' 'ulimit' 'umask' 'unalias' 'unset' 'wait'
  hook -always -once buffer BufSetOption 'filetype=(?!sh).*' %{
    unset-option buffer line_comment_token
    unset-option buffer extra_word_chars
    unset-option buffer static_words
    remove-highlighter buffer/sh
  }
}

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/sh regions
add-highlighter shared/sh/code default-region group

# Syntax and semantics ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

add-highlighter shared/sh/code/function_name_declaration regex '^\h*\K\w+(?=\(\))' 0:function
add-highlighter shared/sh/code/variable_name_declaration regex '\b\w+(?==)' 0:variable
add-highlighter shared/sh/code/alias_name_declaration regex '^\h*alias\h*\K[\w.-]+(?==)' 0:variable
add-highlighter shared/sh/code/variable ref sh.variable

# command_substitution
# add-highlighter shared/sh/string.interpolated.parenthesis region -recurse '\(' '\$\(\K' '(?=\))' ref sh

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# compgen -k
add-highlighter shared/sh/code/keyword regex '\bif\b|\bthen\b|\belse\b|\belif\b|\bfi\b|\bcase\b|\besac\b|\bfor\b|\bselect\b|\bwhile\b|\buntil\b|\bdo\b|\bdone\b|\bin\b|\bfunction\b|\btime\b|\{|\}|!|\[\[|\]\]|\bcoproc\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# compgen -b
add-highlighter shared/sh/code/support.builtin regex '\.|:|\[|\balias\b|\bbg\b|\bbind\b|\bbreak\b|\bbuiltin\b|\bcaller\b|\bcd\b|\bcommand\b|\bcompgen\b|\bcomplete\b|\bcompopt\b|\bcontinue\b|\bdeclare\b|\bdirs\b|\bdisown\b|\becho\b|\benable\b|\beval\b|\bexec\b|\bexit\b|\bexport\b|\bfalse\b|\bfc\b|\bfg\b|\bgetopts\b|\bhash\b|\bhelp\b|\bhistory\b|\bjobs\b|\bkill\b|\blet\b|\blocal\b|\blogout\b|\bmapfile\b|\bpopd\b|\bprintf\b|\bpushd\b|\bpwd\b|\bread\b|\breadarray\b|\breadonly\b|\breturn\b|\bset\b|\bshift\b|\bshopt\b|\bsource\b|\bsuspend\b|\btest\b|\btimes\b|\btrap\b|\btrue\b|\btype\b|\btypeset\b|\bulimit\b|\bumask\b|\bunalias\b|\bunset\b|\bwait\b' 0:builtin

add-highlighter shared/sh/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/sh/code/operator.range regex '\.\.\.?' 0:operator

# Numbers
add-highlighter shared/sh/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

add-highlighter shared/sh/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

add-highlighter shared/sh/comment region '(?<!\\)(\\\\)*(^|\h)\K#' '$' group
add-highlighter shared/sh/comment/fill fill comment

add-highlighter shared/sh/string.quoted.single region "(?<!\\)(\\\\)*\K'" "'" regions
add-highlighter shared/sh/string.quoted.single/content default-region group
add-highlighter shared/sh/string.quoted.single/content/fill fill value
add-highlighter shared/sh/string.quoted.single/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/sh/string.quoted.single/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta

add-highlighter shared/sh/string.quoted.double region '(?<!\\)(\\\\)*\K"' '(?<!\\)(\\\\)*"' group
add-highlighter shared/sh/string.quoted.double/escaped-character regex '\\"' 0:value
add-highlighter shared/sh/string.quoted.double/interpolated ref sh.string.interpolated

add-highlighter shared/sh.string regions
add-highlighter shared/sh.string/content default-region group
add-highlighter shared/sh.string/content/fill fill value
#
add-highlighter shared/sh.string.interpolated regions
add-highlighter shared/sh.string.interpolated/content default-region group
add-highlighter shared/sh.string.interpolated/content/fill fill string
add-highlighter shared/sh.string.interpolated/content/expansion ref sh.variable
add-highlighter shared/sh.string.interpolated/string.interpolated.parenthesis region -recurse '\(' '\$\(\K' '(?=\))' ref sh
#
add-highlighter shared/sh.variable regions
add-highlighter shared/sh.variable/content default-region group
add-highlighter shared/sh.variable/content/named_variable regex '(?<!\\)(\\\\)*\$\K(\w+|[#@?$!*-])' 0:variable
add-highlighter shared/sh.variable/content/positional_variable regex '(?<!\\)(\\\\)*\$\K(\w+|[#@?$!*-])' 0:variable
add-highlighter shared/sh.variable/content/special_variable regex '(?<!\\)(\\\\)*\$\K(\w+|[#@?$!*-])' 0:variable
add-highlighter shared/sh.variable/brace_variable region -recurse '\{' '\$\{\K' '(?=\})' fill variable
#
add-highlighter shared/sh/string.unquoted.heredoc.with_indent.interpolated region -match-capture '<<-(\w+)' '^\t*(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.quoted.single.heredoc.with_indent.raw region -match-capture "<<-'(\w+)'" '^\t*(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc.with_indent.raw region -match-capture '<<-"(\w+)"' '^\t*(\w+)$' ref sh.string
add-highlighter shared/sh/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.quoted.single.heredoc.raw region -match-capture "<<-'(\w+)'" '^(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc.raw region -match-capture '<<-"(\w+)"' '^(\w+)$' ref sh.string
