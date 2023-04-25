# sh
# https://sh.org

# kakoune-sh
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [sh] programming language.

# [Kakoune]: https://kakoune.org
# [sh]: https://sh-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'sh word pattern' str sh_word_pattern '\w+[?!]?'

# Reference
#
# https://sh-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://sh-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://sh-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://sh-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://sh-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
#
# class Person
# end
#
# private class Person
# end
#
# abstract class Person
# end
#
# private abstract class Person
# end
#
# def name
# end
#
# private def name
# end
#
# protected def name
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module sh
# end
#
# private module sh
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/structs.html
#
# struct Point
# end
#
# private struct Point
# end
#
# abstract struct Point
# end
#
# private abstract struct Point
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://sh-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://sh-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets sh filetype when opening `.sh` files.
remove-hooks global sh-detection
hook -group sh-detection global BufCreate '.+\.sh' %{
  set-option buffer filetype sh
}

# Enables syntax highlighting for sh filetype.
remove-hooks global sh-highlight
hook -group sh-highlight global WinSetOption filetype=sh %{
  add-highlighter window/sh ref sh
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/sh
  }
}

# Configures word selection and completion for sh filetype.
# `static_words` option is generated with `sh-check-news`.
remove-hooks global sh-config
hook -group sh-config global WinSetOption filetype=sh %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option window line_comment_token '#'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option window static_words 'abort' 'abstract' 'alias' 'annotation' 'as' 'as?' 'asm' 'at_exit' 'begin' 'break' 'caller' 'case' 'class' 'class_getter' 'class_getter!' 'class_getter?' 'class_property' 'class_property!' 'class_property?' 'class_setter' 'debugger' 'def' 'def_clone' 'def_equals' 'def_equals_and_hash' 'def_hash' 'delegate' 'do' 'else' 'elsif' 'end' 'ensure' 'enum' 'exit' 'extend' 'false' 'for' 'forward_missing_to' 'fun' 'gets' 'getter' 'getter!' 'getter?' 'if' 'in' 'include' 'instance_sizeof' 'is_a?' 'lib' 'loop' 'macro' 'main' 'module' 'next' 'nil' 'nil?' 'of' 'offsetof' 'out' 'p' 'p!' 'pointerof' 'pp' 'pp!' 'print' 'printf' 'private' 'property' 'property!' 'property?' 'protected' 'puts' 'raise' 'raise_without_backtrace' 'rand' 'read_line' 'record' 'require' 'rescue' 'responds_to?' 'return' 'select' 'self' 'setter' 'sizeof' 'sleep' 'spawn' 'sprintf' 'struct' 'super' 'system' 'then' 'timeout_select_action' 'true' 'type' 'typeof' 'uninitialized' 'union' 'unless' 'until' 'verbatim' 'when' 'while' 'with' 'yield'
  hook -always -once window WinSetOption 'filetype=.*' %{
    unset-option window line_comment_token
    unset-option buffer extra_word_chars
    unset-option window static_words
  }
}

# Indentation ──────────────────────────────────────────────────────────────────

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/sh regions
add-highlighter shared/sh/code default-region group

# TODO
# syntax "**/*.sh"
# syntax keywords "done|do|echo|elif|else|exit|export|for|fi|function|if|in|return|then|while"
# syntax types "%$%w{%w_}|%$%{{!%}.}"
# syntax symbols "%(|%)|%[|%]|%{|%}|<|>|=|~|*|&|%!|%||@|;|%$"
# syntax literals "-%w{%w_-}|%d{%w}"
# syntax strings {'{(\\)(\')!'.}|"{(\\)(\")!".}}
# syntax comments "#{.}"
# syntax texts "{%w_-%.}"
# Generated with `compgen -k` in bash keywords
# Generated with `compgen -b` in bash builtins
add-highlighter shared/sh/arithmetic region -recurse \(.*?\( (\$|(?<=for)\h*)\(\( \)\) group
add-highlighter shared/sh/double_string region  %{(?<!\\)(?:\\\\)*\K"} %{(?<!\\)(?:\\\\)*"} group
add-highlighter shared/sh/single_string region %{(?<!\\)(?:\\\\)*\K'} %{'} fill string
add-highlighter shared/sh/expansion region -recurse (?<!\\)(?:\\\\)*\K\$\{ (?<!\\)(?:\\\\)*\K\$\{ \}|\n fill value
add-highlighter shared/sh/comment2 region (?<!\\)(?:\\\\)*(?:^|\h)\K# '$' fill comment
add-highlighter shared/sh/heredoc region -match-capture '<<-?\h*''?(\w+)''?' '^\t*(\w+)$' fill string
add-highlighter shared/sh/arithmetic/expansion ref sh/double_string/expansion
add-highlighter shared/sh/double_string/fill fill string
add-highlighter shared/sh/code/operators regex [\[\]\(\)&|]{1,2} 0:operator
add-highlighter shared/sh/code/variable regex ((?<![-:])\b\w+)= 1:variable
add-highlighter shared/sh/code/alias regex \balias(\h+[-+]\w)*\h+([\w-.]+)= 2:variable
add-highlighter shared/sh/code/function regex ^\h*(\S+(?<!=))\h*\(\) 1:function
add-highlighter shared/sh/code/unscoped_expansion regex (?<!\\)(?:\\\\)*\K\$(\w+|#|@|\?|\$|!|-|\*) 0:value
add-highlighter shared/sh/double_string/expansion regex (?<!\\)(?:\\\\)*\K\$(\w+|#|@|\?|\$|!|-|\*|\{.+?\}) 0:value
#

# Syntax and semantics ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Classes
# Comments
# Constants
# Entities
# Functions/Methods
# Keywords
# Language Built-ins
# Punctuation
# Storage
# Strings
# Variables

# Scope Naming
# Naming conventions
# Sublime Text
# TextMate
# https://docs.helix-editor.com/themes.html#syntax-highlighting
# https://macromates.com/manual/en/language_grammars
# https://github.com/sh-lang-tools/vscode-sh-lang/blob/master/syntaxes/sh.sh
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/sh/code/instance-method-definition regex "\b(def)\h+(%opt{sh_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/sh/code/class-method-definition regex "\b(def)\h+(self\.%opt{sh_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/sh/code/method-call regex "\b(%opt{sh_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://sh-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/sh/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `sh-check-news`.
add-highlighter shared/sh/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `sh-check-news`.
add-highlighter shared/sh/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/sh/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

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
add-highlighter shared/sh/comment region '#(?!\{)' '$' group
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
add-highlighter shared/sh/comment/reference regex "`[#.]?%opt{sh_word_pattern}`" 0:mono
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
add-highlighter shared/sh/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/sh/string/content default-region group
add-highlighter shared/sh/string/content/fill fill value
add-highlighter shared/sh/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/sh/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-sh-string string.character value "'" "(?<!\\)(\\\\)*'"

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
add-highlighter shared/sh/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/sh/string.interpolated/content default-region group
add-highlighter shared/sh/string.interpolated/content/fill fill string
add-highlighter shared/sh/string.interpolated/content/escaped-character ref sh/string/content/escaped-character
add-highlighter shared/sh/string.interpolated/content/escape-sequence ref sh/string/content/escape-sequence
add-highlighter shared/sh/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/sh/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/sh/string.interpolated/interpolation/sh ref sh
# define-sh-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

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
add-highlighter shared/sh/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref sh/string.interpolated
add-highlighter shared/sh/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref sh/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/sh/code/constant.symbol regex ":%opt{sh_word_pattern}" 0:value
add-highlighter shared/sh/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref sh/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/sh/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/sh/string.regexp.interpolated/content default-region group
add-highlighter shared/sh/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/sh/string.regexp.interpolated/content/escaped-character ref sh/string/content/escaped-character
add-highlighter shared/sh/string.regexp.interpolated/content/escape-sequence ref sh/string/content/escape-sequence
add-highlighter shared/sh/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/sh/string.regexp.interpolated/interpolation/delimiters ref sh/string.interpolated/interpolation/delimiters
add-highlighter shared/sh/string.regexp.interpolated/interpolation/sh ref sh

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/sh/division-as-region region ' //? ' '.\K' group
add-highlighter shared/sh/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/sh/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref sh/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://sh-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/sh/string.command region '`' '(?<!\\)(\\\\)*`' ref sh/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/sh/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.command.percent.angle region -recurse '<' '%x<' '>' ref sh/string.regexp.interpolated
add-highlighter shared/sh/string.command.percent.pipe region '%x\|' '\|' ref sh/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `sh-build-result keywords`.
#
define-command -hidden sh-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug sh %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug sh %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden sh-build-result-with-static-words -params 1 %{
  sh-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden sh-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/sh-lang/sh/blob/master/src/compiler/sh/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/sh-lang/sh/raw/master/src/compiler/sh/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{sh_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{sh_word_pattern}<a-!>)<ret><a-z>a'
  sh-build-result-with-static-words keywords

  # Top Level Namespace
  # https://sh-lang.org/api/master/toplevel.html#method-summary
  # https://sh-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://sh-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{sh_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  sh-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://sh-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://sh-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{sh_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  sh-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  sh-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
