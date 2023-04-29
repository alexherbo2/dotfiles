# Lua
# https://lua.org

# kakoune-lua
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Lua] programming language.

# [Kakoune]: https://kakoune.org
# [Lua]: https://lua-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Lua word pattern' str lua_word_pattern '\w+[?!]?'

# Reference
#
# https://lua-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://lua-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://lua-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://lua-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://lua-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://lua-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module Lua
# end
#
# private module Lua
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://lua-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://lua-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://lua-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Lua filetype when opening `.lua` files.
remove-hooks global lua-detection
hook -group lua-detection global BufCreate '.+\.lua' %{
  set-option buffer filetype lua
}

# Enables syntax highlighting for Lua filetype.
remove-hooks global lua-highlight
hook -group lua-highlight global WinSetOption filetype=lua %{
  add-highlighter window/lua ref lua
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/lua
  }
}

# Configures word selection and completion for Lua filetype.
# `static_words` option is generated with `lua-check-news`.
remove-hooks global lua-config
hook -group lua-config global WinSetOption filetype=lua %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option buffer line_comment_token '--'
  set-option buffer block_comment_tokens '[[--' '--]]'
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
add-highlighter shared/lua regions
add-highlighter shared/lua/code default-region group

# TODO:
# # https://www.lua.org/manual/5.1/manual.html#2
# syntax "**/*.lua"
# syntax keywords and|break|do|elseif|else|end|for|function|if|in|local|not|or|repeat|return|then|until|while
# syntax types "%u{%w_}"
# syntax symbols "+|-|*|/|%%|%^|#|<|>|=|~|%(|%)|%{|%}|%[|%]|;|%.|:|,|%.|%.%.|%.%.%."
# syntax literals "nil|false|true|_G|_ENV|%d{%d_}%.%w{%w_}|%d{%w_}"
# syntax strings {'{(\\)(\')!'.}|"{(\\)(\")!".}|%[%[{!(%]%]).}}
# syntax comments "--{.}|--%[%[{!(%]%]).$}"
add-highlighter shared/lua/raw_string  region -match-capture   '\[(=*)\[' '\](=*)\]' fill string
add-highlighter shared/lua/raw_comment region -match-capture '--\[(=*)\[' '\](=*)\]' fill comment
add-highlighter shared/lua/double_string region '"'   (?<!\\)(?:\\\\)*" fill string
add-highlighter shared/lua/single_string region "'"   (?<!\\)(?:\\\\)*' fill string
add-highlighter shared/lua/comment2       region '--'  $                 fill comment
add-highlighter shared/lua/code/function_declaration regex \b(?:function\h+)(?:\w+\h*\.\h*)*([a-zA-Z_]\w*)\( 1:function
add-highlighter shared/lua/code/function_call regex \b([a-zA-Z_]\w*)\h*(?=[\(\{]) 1:function
add-highlighter shared/lua/code/keyword2 regex \b(break|do|else|elseif|end|for|function|goto|if|in|local|repeat|return|then|until|while)\b 0:keyword
add-highlighter shared/lua/code/value regex \b(false|nil|true|[0-9]+(:?\.[0-9])?(:?[eE]-?[0-9]+)?|0x[0-9a-fA-F])\b 0:value
add-highlighter shared/lua/code/symbolic_operator regex (\+|-|\*|/|%|\^|==?|~=|<=?|>=?|\.\.|\.\.\.|#) 0:operator
add-highlighter shared/lua/code/keyword_operator regex \b(and|or|not)\b 0:operator
add-highlighter shared/lua/code/module regex \b(_G|_ENV)\b 0:module
add-highlighter shared/lua/code/attribute regex \B(<[a-zA-Z_]\w*>)\B 0:attribute
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
# https://github.com/lua-lang-tools/vscode-lua-lang/blob/master/syntaxes/lua.lua
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/lua/code/instance-method-definition regex "\b(def)\h+(%opt{lua_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/lua/code/class-method-definition regex "\b(def)\h+(self\.%opt{lua_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/lua/code/method-call regex "\b(%opt{lua_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://lua-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/lua/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `lua-check-news`.
add-highlighter shared/lua/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `lua-check-news`.
add-highlighter shared/lua/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/lua/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/lua/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/lua/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/lua/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/lua/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/lua/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/lua/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/lua/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/lua/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/lua/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/lua/comment region '#(?!\{)' '$' group
add-highlighter shared/lua/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/lua/comment/reference regex "`[#.]?%opt{lua_word_pattern}`" 0:mono
add-highlighter shared/lua/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/lua/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/lua/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/lua/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Lua raw string.
#
# Syntax:
#
# define-lua-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-lua-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list lua_optional_arguments
define-command -hidden define-lua-string -params 4.. %{
  set-option global lua_optional_arguments %arg{@}
  set-option -remove global lua_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/lua/%arg{1}" region %opt{lua_optional_arguments} regions
  add-highlighter "shared/lua/%arg{1}/content" default-region group
  add-highlighter "shared/lua/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/lua/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/lua/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Lua string interpolation.
#
# Syntax:
#
# define-lua-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-lua-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-lua-interpolated-string -params 4.. %{
  define-lua-string %arg{@}
  add-highlighter "shared/lua/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/lua/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/lua/%arg{1}/interpolation/lua" ref lua
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/lua/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/lua/string/content default-region group
add-highlighter shared/lua/string/content/fill fill value
add-highlighter shared/lua/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/lua/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-lua-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/lua/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/lua/string.interpolated/content default-region group
add-highlighter shared/lua/string.interpolated/content/fill fill string
add-highlighter shared/lua/string.interpolated/content/escaped-character ref lua/string/content/escaped-character
add-highlighter shared/lua/string.interpolated/content/escape-sequence ref lua/string/content/escape-sequence
add-highlighter shared/lua/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/lua/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/lua/string.interpolated/interpolation/lua ref lua
# define-lua-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/lua/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref lua/string.interpolated
add-highlighter shared/lua/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref lua/string.interpolated
add-highlighter shared/lua/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref lua/string.interpolated
add-highlighter shared/lua/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref lua/string.interpolated
add-highlighter shared/lua/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref lua/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/lua/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref lua/string
add-highlighter shared/lua/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref lua/string
add-highlighter shared/lua/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref lua/string
add-highlighter shared/lua/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref lua/string
add-highlighter shared/lua/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref lua/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/lua/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref lua/string.interpolated
add-highlighter shared/lua/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref lua/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/lua/code/constant.symbol regex ":%opt{lua_word_pattern}" 0:value
add-highlighter shared/lua/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref lua/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/lua/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/lua/string.regexp.interpolated/content default-region group
add-highlighter shared/lua/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/lua/string.regexp.interpolated/content/escaped-character ref lua/string/content/escaped-character
add-highlighter shared/lua/string.regexp.interpolated/content/escape-sequence ref lua/string/content/escape-sequence
add-highlighter shared/lua/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/lua/string.regexp.interpolated/interpolation/delimiters ref lua/string.interpolated/interpolation/delimiters
add-highlighter shared/lua/string.regexp.interpolated/interpolation/lua ref lua

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/lua/division-as-region region ' //? ' '.\K' group
add-highlighter shared/lua/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/lua/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref lua/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://lua-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/lua/string.command region '`' '(?<!\\)(\\\\)*`' ref lua/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/lua/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.command.percent.angle region -recurse '<' '%x<' '>' ref lua/string.regexp.interpolated
add-highlighter shared/lua/string.command.percent.pipe region '%x\|' '\|' ref lua/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `lua-build-result keywords`.
#
define-command -hidden lua-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug lua %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug lua %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden lua-build-result-with-static-words -params 1 %{
  lua-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden lua-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/lua-lang/lua/blob/master/src/compiler/lua/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/lua-lang/lua/raw/master/src/compiler/lua/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{lua_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{lua_word_pattern}<a-!>)<ret><a-z>a'
  lua-build-result-with-static-words keywords

  # Top Level Namespace
  # https://lua-lang.org/api/master/toplevel.html#method-summary
  # https://lua-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://lua-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{lua_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  lua-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://lua-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://lua-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{lua_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  lua-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  lua-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
