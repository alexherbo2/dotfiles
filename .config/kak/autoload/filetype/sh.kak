# sh
# https://sh.org

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

# TODO
# add-highlighter shared/sh/arithmetic region -recurse \(.*?\( (\$|(?<=for)\h*)\(\( \)\) group
# add-highlighter shared/sh/expansion region -recurse (?<!\\)(?:\\\\)*\K\$\{ (?<!\\)(?:\\\\)*\K\$\{ \}|\n fill value
# add-highlighter shared/sh/arithmetic/expansion ref sh/double_string/expansion
# add-highlighter shared/sh/code/operators regex [\[\]\(\)&|]{1,2} 0:operator
# add-highlighter shared/sh/code/variable regex ((?<![-:])\b\w+)= 1:variable
# add-highlighter shared/sh/code/alias regex \balias(\h+[-+]\w)*\h+([\w-.]+)= 2:variable
# add-highlighter shared/sh/code/function regex ^\h*(\S+(?<!=))\h*\(\) 1:function
#

# Syntax and semantics ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

add-highlighter shared/sh/code/function_name_declaration regex '^\h*\K\w+(?=\(\))' 0:function
add-highlighter shared/sh/code/variable_name_declaration regex '\b\w+(?==)' 0:variable
add-highlighter shared/sh/code/alias_name_declaration regex '^\h*alias\h*\K[\w.-]+(?==)' 0:variable

add-highlighter shared/sh/code/expansion regex '(?<!\\)(\\\\)*\K\$(\w+|[#@?$!*-]|\{.+?\})' 0:value

# command_substitution
# add-highlighter shared/sh/string.interpolated.parenthesis region -recurse '\(' '\$\(\K' '(?=\))' ref sh

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

add-highlighter shared/sh/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# compgen -k
add-highlighter shared/sh/code/keyword regex '\bif\b|\bthen\b|\belse\b|\belif\b|\bfi\b|\bcase\b|\besac\b|\bfor\b|\bselect\b|\bwhile\b|\buntil\b|\bdo\b|\bdone\b|\bin\b|\bfunction\b|\btime\b|\{|\}|!|\[\[|\]\]|\bcoproc\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# compgen -b
add-highlighter shared/sh/code/support.builtin regex '\.|:|\[|\balias\b|\bbg\b|\bbind\b|\bbreak\b|\bbuiltin\b|\bcaller\b|\bcd\b|\bcommand\b|\bcompgen\b|\bcomplete\b|\bcompopt\b|\bcontinue\b|\bdeclare\b|\bdirs\b|\bdisown\b|\becho\b|\benable\b|\beval\b|\bexec\b|\bexit\b|\bexport\b|\bfalse\b|\bfc\b|\bfg\b|\bgetopts\b|\bhash\b|\bhelp\b|\bhistory\b|\bjobs\b|\bkill\b|\blet\b|\blocal\b|\blogout\b|\bmapfile\b|\bpopd\b|\bprintf\b|\bpushd\b|\bpwd\b|\bread\b|\breadarray\b|\breadonly\b|\breturn\b|\bset\b|\bshift\b|\bshopt\b|\bsource\b|\bsuspend\b|\btest\b|\btimes\b|\btrap\b|\btrue\b|\btype\b|\btypeset\b|\bulimit\b|\bumask\b|\bunalias\b|\bunset\b|\bwait\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/sh/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/sh/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/sh/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/sh/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/sh/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/sh/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/sh/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/sh/comment region '(?<!\\)(\\\\)*(^|\h)\K#' '$' group
add-highlighter shared/sh/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/documenting_code.html

# Example:
#
# A unicorn is a **legendary animal**.
#
# To create a unicorn:
#
# ```
# unicorn = Unicorn.new
# unicorn.speak
# ```
#
# Check the number of horns with `#horns`.
#
# add-highlighter shared/sh/comment/reference regex "`[#.]?%opt{sh_word_pattern}`" 0:mono
add-highlighter shared/sh/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/sh/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/sh/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/sh/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines sh raw string.
#
# Syntax:
#
# define-sh-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-sh-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list sh_optional_arguments
define-command -hidden define-sh-string -params 4.. %{
  set-option global sh_optional_arguments %arg{@}
  set-option -remove global sh_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/sh/%arg{1}" region %opt{sh_optional_arguments} regions
  add-highlighter "shared/sh/%arg{1}/content" default-region group
  add-highlighter "shared/sh/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/sh/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/sh/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines sh string interpolation.
#
# Syntax:
#
# define-sh-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-sh-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-sh-interpolated-string -params 4.. %{
  define-sh-string %arg{@}
  add-highlighter "shared/sh/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/sh/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/sh/%arg{1}/interpolation/sh" ref sh
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/sh/string.quoted.single region "(?<!\\)(\\\\)*\K'" "'" regions
add-highlighter shared/sh/string.quoted.single/content default-region group
add-highlighter shared/sh/string.quoted.single/content/fill fill value
add-highlighter shared/sh/string.quoted.single/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/sh/string.quoted.single/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
add-highlighter shared/sh/string.quoted.single/content/expansion ref sh/code/expansion

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/sh/string.quoted.double region '(?<!\\)(\\\\)*\K"' '(?<!\\)(\\\\)*"' group
add-highlighter shared/sh/string.quoted.double/escaped-character regex '\\"' 0:meta
add-highlighter shared/sh/string.quoted.double/interpolated ref sh.string.interpolated

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/sh/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref sh/string.interpolated
add-highlighter shared/sh/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref sh/string.interpolated
add-highlighter shared/sh/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref sh/string.interpolated
add-highlighter shared/sh/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref sh/string.interpolated
add-highlighter shared/sh/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref sh/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/sh/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref sh/string
add-highlighter shared/sh/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref sh/string
add-highlighter shared/sh/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref sh/string
add-highlighter shared/sh/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref sh/string
add-highlighter shared/sh/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref sh/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/sh.string regions
add-highlighter shared/sh.string/content default-region group
add-highlighter shared/sh.string/content/fill fill value
#
add-highlighter shared/sh.string.interpolated regions
add-highlighter shared/sh.string.interpolated/content default-region group
add-highlighter shared/sh.string.interpolated/content/fill fill string
add-highlighter shared/sh.string.interpolated/content/expansion ref sh/code/expansion
add-highlighter shared/sh.string.interpolated/string.interpolated.parenthesis region -recurse '\(' '\$\(\K' '(?=\))' ref sh
#
#
add-highlighter shared/sh/string.unquoted.heredoc.with_indent.interpolated region -match-capture '<<-(\w+)' '^\t*(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.quoted.single.heredoc.with_indent.raw region -match-capture "<<-'(\w+)'" '^\t*(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc.with_indent.raw region -match-capture '<<-"(\w+)"' '^\t*(\w+)$' ref sh.string
add-highlighter shared/sh/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^(\w+)$' ref sh.string.interpolated
add-highlighter shared/sh/string.quoted.single.heredoc.raw region -match-capture "<<-'(\w+)'" '^(\w+)$' ref sh.string
add-highlighter shared/sh/string.quoted.double.heredoc.raw region -match-capture '<<-"(\w+)"' '^(\w+)$' ref sh.string
