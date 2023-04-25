# Dockerfile
# https://dockerfile.org

# kakoune-dockerfile
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Dockerfile] programming language.

# [Kakoune]: https://kakoune.org
# [Dockerfile]: https://dockerfile-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Dockerfile word pattern' str dockerfile_word_pattern '\w+[?!]?'

# Reference
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module Dockerfile
# end
#
# private module Dockerfile
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Dockerfile filetype when opening `.dockerfile` files.
remove-hooks global dockerfile-detection
hook -group dockerfile-detection global BufCreate '.+/Dockerfile' %{
  set-option buffer filetype dockerfile
}

# Enables syntax highlighting for Dockerfile filetype.
remove-hooks global dockerfile-highlight
hook -group dockerfile-highlight global WinSetOption filetype=dockerfile %{
  add-highlighter window/dockerfile ref dockerfile
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/dockerfile
  }
}

# Configures word selection and completion for Dockerfile filetype.
# `static_words` option is generated with `dockerfile-check-news`.
remove-hooks global dockerfile-config
hook -group dockerfile-config global WinSetOption filetype=dockerfile %{
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
add-highlighter shared/dockerfile regions
add-highlighter shared/dockerfile/code default-region group

# TODO
# See https://docs.docker.com/reference/builder
add-highlighter shared/dockerfile/double_string region '"' '(?<!\\)(\\\\)*"' fill string
add-highlighter shared/dockerfile/single_string region "'" "'"               fill string
add-highlighter shared/dockerfile/comment2 region '#' $ fill comment
add-highlighter shared/dockerfile/code/ regex '^(?i)(ONBUILD\h+)?(ADD|ARG|CMD|COPY|ENTRYPOINT|ENV|EXPOSE|FROM|HEALTHCHECK|LABEL|MAINTAINER|RUN|SHELL|STOPSIGNAL|USER|VOLUME|WORKDIR)\b' 2:keyword
add-highlighter shared/dockerfile/code/ regex '^(?i)(ONBUILD)\h+' 1:keyword
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
# https://github.com/dockerfile-lang-tools/vscode-dockerfile-lang/blob/master/syntaxes/dockerfile.dockerfile
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/dockerfile/code/instance-method-definition regex "\b(def)\h+(%opt{dockerfile_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/dockerfile/code/class-method-definition regex "\b(def)\h+(self\.%opt{dockerfile_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/dockerfile/code/method-call regex "\b(%opt{dockerfile_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/dockerfile/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `dockerfile-check-news`.
add-highlighter shared/dockerfile/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `dockerfile-check-news`.
add-highlighter shared/dockerfile/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/dockerfile/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/dockerfile/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/dockerfile/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/dockerfile/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/dockerfile/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/dockerfile/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/dockerfile/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/dockerfile/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/dockerfile/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/dockerfile/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/dockerfile/comment region '#(?!\{)' '$' group
add-highlighter shared/dockerfile/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/dockerfile/comment/reference regex "`[#.]?%opt{dockerfile_word_pattern}`" 0:mono
add-highlighter shared/dockerfile/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/dockerfile/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/dockerfile/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/dockerfile/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Dockerfile raw string.
#
# Syntax:
#
# define-dockerfile-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-dockerfile-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list dockerfile_optional_arguments
define-command -hidden define-dockerfile-string -params 4.. %{
  set-option global dockerfile_optional_arguments %arg{@}
  set-option -remove global dockerfile_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/dockerfile/%arg{1}" region %opt{dockerfile_optional_arguments} regions
  add-highlighter "shared/dockerfile/%arg{1}/content" default-region group
  add-highlighter "shared/dockerfile/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/dockerfile/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/dockerfile/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Dockerfile string interpolation.
#
# Syntax:
#
# define-dockerfile-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-dockerfile-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-dockerfile-interpolated-string -params 4.. %{
  define-dockerfile-string %arg{@}
  add-highlighter "shared/dockerfile/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/dockerfile/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/dockerfile/%arg{1}/interpolation/dockerfile" ref dockerfile
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/dockerfile/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/dockerfile/string/content default-region group
add-highlighter shared/dockerfile/string/content/fill fill value
add-highlighter shared/dockerfile/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/dockerfile/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-dockerfile-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/dockerfile/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/dockerfile/string.interpolated/content default-region group
add-highlighter shared/dockerfile/string.interpolated/content/fill fill string
add-highlighter shared/dockerfile/string.interpolated/content/escaped-character ref dockerfile/string/content/escaped-character
add-highlighter shared/dockerfile/string.interpolated/content/escape-sequence ref dockerfile/string/content/escape-sequence
add-highlighter shared/dockerfile/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/dockerfile/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/dockerfile/string.interpolated/interpolation/dockerfile ref dockerfile
# define-dockerfile-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/dockerfile/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref dockerfile/string.interpolated
add-highlighter shared/dockerfile/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref dockerfile/string.interpolated
add-highlighter shared/dockerfile/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref dockerfile/string.interpolated
add-highlighter shared/dockerfile/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref dockerfile/string.interpolated
add-highlighter shared/dockerfile/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref dockerfile/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/dockerfile/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref dockerfile/string
add-highlighter shared/dockerfile/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref dockerfile/string
add-highlighter shared/dockerfile/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref dockerfile/string
add-highlighter shared/dockerfile/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref dockerfile/string
add-highlighter shared/dockerfile/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref dockerfile/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/dockerfile/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref dockerfile/string.interpolated
add-highlighter shared/dockerfile/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref dockerfile/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/dockerfile/code/constant.symbol regex ":%opt{dockerfile_word_pattern}" 0:value
add-highlighter shared/dockerfile/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref dockerfile/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/dockerfile/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/dockerfile/string.regexp.interpolated/content default-region group
add-highlighter shared/dockerfile/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/dockerfile/string.regexp.interpolated/content/escaped-character ref dockerfile/string/content/escaped-character
add-highlighter shared/dockerfile/string.regexp.interpolated/content/escape-sequence ref dockerfile/string/content/escape-sequence
add-highlighter shared/dockerfile/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/dockerfile/string.regexp.interpolated/interpolation/delimiters ref dockerfile/string.interpolated/interpolation/delimiters
add-highlighter shared/dockerfile/string.regexp.interpolated/interpolation/dockerfile ref dockerfile

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/dockerfile/division-as-region region ' //? ' '.\K' group
add-highlighter shared/dockerfile/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/dockerfile/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref dockerfile/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://dockerfile-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/dockerfile/string.command region '`' '(?<!\\)(\\\\)*`' ref dockerfile/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/dockerfile/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.command.percent.angle region -recurse '<' '%x<' '>' ref dockerfile/string.regexp.interpolated
add-highlighter shared/dockerfile/string.command.percent.pipe region '%x\|' '\|' ref dockerfile/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `dockerfile-build-result keywords`.
#
define-command -hidden dockerfile-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug dockerfile %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug dockerfile %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden dockerfile-build-result-with-static-words -params 1 %{
  dockerfile-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden dockerfile-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/dockerfile-lang/dockerfile/blob/master/src/compiler/dockerfile/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/dockerfile-lang/dockerfile/raw/master/src/compiler/dockerfile/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{dockerfile_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{dockerfile_word_pattern}<a-!>)<ret><a-z>a'
  dockerfile-build-result-with-static-words keywords

  # Top Level Namespace
  # https://dockerfile-lang.org/api/master/toplevel.html#method-summary
  # https://dockerfile-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://dockerfile-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{dockerfile_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  dockerfile-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://dockerfile-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://dockerfile-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{dockerfile_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  dockerfile-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  dockerfile-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
