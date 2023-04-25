# Makefile
# https://makefile.org

# kakoune-makefile
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Makefile] programming language.

# [Kakoune]: https://kakoune.org
# [Makefile]: https://makefile-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Makefile word pattern' str makefile_word_pattern '\w+[?!]?'

# Reference
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://makefile-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://makefile-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://makefile-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module Makefile
# end
#
# private module Makefile
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://makefile-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://makefile-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://makefile-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Makefile filetype when opening `Makefile` files.
remove-hooks global makefile-detection
hook -group makefile-detection global BufCreate '.+/Makefile' %{
  set-option buffer filetype makefile
}

# Enables syntax highlighting for Makefile filetype.
remove-hooks global makefile-highlight
hook -group makefile-highlight global WinSetOption filetype=makefile %{
  add-highlighter window/makefile ref makefile
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/makefile
  }
}

# Configures word selection and completion for Makefile filetype.
# `static_words` option is generated with `makefile-check-news`.
remove-hooks global makefile-config
hook -group makefile-config global WinSetOption filetype=makefile %{
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
add-highlighter shared/makefile regions
add-highlighter shared/makefile/code default-region group

# TODO
# s/code/content/
add-highlighter shared/makefile/evaluate-commands region -recurse \( (?<!\$)(?:\$\$)*\K\$\( \) fill value
add-highlighter shared/makefile/code/ regex ^\S.*?(::|:|!)\s 0:variable
add-highlighter shared/makefile/code/ regex [+?:]= 0:operator
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
# https://github.com/makefile-lang-tools/vscode-makefile-lang/blob/master/syntaxes/makefile.makefile
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/makefile/code/instance-method-definition regex "\b(def)\h+(%opt{makefile_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/makefile/code/class-method-definition regex "\b(def)\h+(self\.%opt{makefile_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/makefile/code/method-call regex "\b(%opt{makefile_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://makefile-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/makefile/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `makefile-check-news`.
add-highlighter shared/makefile/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `makefile-check-news`.
add-highlighter shared/makefile/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/makefile/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/makefile/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/makefile/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/makefile/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/makefile/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/makefile/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/makefile/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/makefile/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/makefile/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/makefile/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/makefile/comment region '#(?!\{)' '$' group
add-highlighter shared/makefile/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/makefile/comment/reference regex "`[#.]?%opt{makefile_word_pattern}`" 0:mono
add-highlighter shared/makefile/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/makefile/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/makefile/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/makefile/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Makefile raw string.
#
# Syntax:
#
# define-makefile-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-makefile-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list makefile_optional_arguments
define-command -hidden define-makefile-string -params 4.. %{
  set-option global makefile_optional_arguments %arg{@}
  set-option -remove global makefile_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/makefile/%arg{1}" region %opt{makefile_optional_arguments} regions
  add-highlighter "shared/makefile/%arg{1}/content" default-region group
  add-highlighter "shared/makefile/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/makefile/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/makefile/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Makefile string interpolation.
#
# Syntax:
#
# define-makefile-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-makefile-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-makefile-interpolated-string -params 4.. %{
  define-makefile-string %arg{@}
  add-highlighter "shared/makefile/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/makefile/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/makefile/%arg{1}/interpolation/makefile" ref makefile
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/makefile/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/makefile/string/content default-region group
add-highlighter shared/makefile/string/content/fill fill value
add-highlighter shared/makefile/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/makefile/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-makefile-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/makefile/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/makefile/string.interpolated/content default-region group
add-highlighter shared/makefile/string.interpolated/content/fill fill string
add-highlighter shared/makefile/string.interpolated/content/escaped-character ref makefile/string/content/escaped-character
add-highlighter shared/makefile/string.interpolated/content/escape-sequence ref makefile/string/content/escape-sequence
add-highlighter shared/makefile/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/makefile/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/makefile/string.interpolated/interpolation/makefile ref makefile
# define-makefile-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/makefile/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref makefile/string.interpolated
add-highlighter shared/makefile/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref makefile/string.interpolated
add-highlighter shared/makefile/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref makefile/string.interpolated
add-highlighter shared/makefile/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref makefile/string.interpolated
add-highlighter shared/makefile/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref makefile/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/makefile/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref makefile/string
add-highlighter shared/makefile/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref makefile/string
add-highlighter shared/makefile/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref makefile/string
add-highlighter shared/makefile/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref makefile/string
add-highlighter shared/makefile/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref makefile/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/makefile/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref makefile/string.interpolated
add-highlighter shared/makefile/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref makefile/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/makefile/code/constant.symbol regex ":%opt{makefile_word_pattern}" 0:value
add-highlighter shared/makefile/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref makefile/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/makefile/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/makefile/string.regexp.interpolated/content default-region group
add-highlighter shared/makefile/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/makefile/string.regexp.interpolated/content/escaped-character ref makefile/string/content/escaped-character
add-highlighter shared/makefile/string.regexp.interpolated/content/escape-sequence ref makefile/string/content/escape-sequence
add-highlighter shared/makefile/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/makefile/string.regexp.interpolated/interpolation/delimiters ref makefile/string.interpolated/interpolation/delimiters
add-highlighter shared/makefile/string.regexp.interpolated/interpolation/makefile ref makefile

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/makefile/division-as-region region ' //? ' '.\K' group
add-highlighter shared/makefile/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/makefile/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref makefile/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://makefile-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/makefile/string.command region '`' '(?<!\\)(\\\\)*`' ref makefile/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/makefile/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.command.percent.angle region -recurse '<' '%x<' '>' ref makefile/string.regexp.interpolated
add-highlighter shared/makefile/string.command.percent.pipe region '%x\|' '\|' ref makefile/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `makefile-build-result keywords`.
#
define-command -hidden makefile-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug makefile %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug makefile %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden makefile-build-result-with-static-words -params 1 %{
  makefile-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden makefile-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/makefile-lang/makefile/blob/master/src/compiler/makefile/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/makefile-lang/makefile/raw/master/src/compiler/makefile/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{makefile_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{makefile_word_pattern}<a-!>)<ret><a-z>a'
  makefile-build-result-with-static-words keywords

  # Top Level Namespace
  # https://makefile-lang.org/api/master/toplevel.html#method-summary
  # https://makefile-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://makefile-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{makefile_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  makefile-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://makefile-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://makefile-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{makefile_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  makefile-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  makefile-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
