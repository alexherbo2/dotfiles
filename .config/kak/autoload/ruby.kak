# Ruby
# https://ruby-lang.org

# kakoune-ruby
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Ruby] programming language.

# [Kakoune]: https://kakoune.org
# [Ruby]: https://ruby-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Ruby word pattern' str ruby_word_pattern '\w+[?!]?'

# Reference
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://ruby-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://ruby-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://ruby-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module JSON
# end
#
# private module JSON
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://ruby-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://ruby-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://ruby-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Ruby filetype when opening `.cr` files.
remove-hooks global ruby-detection
hook -group ruby-detection global BufCreate '.+\.rb' %{
  set-option buffer filetype ruby
}

# Enables syntax highlighting for Ruby filetype.
remove-hooks global ruby-highlight
hook -group ruby-highlight global WinSetOption filetype=ruby %{
  add-highlighter window/ruby ref ruby
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/ruby
  }
}

# Configures word selection and completion for Ruby filetype.
# `static_words` option is generated with `ruby-check-news`.
remove-hooks global ruby-config
hook -group ruby-config global WinSetOption filetype=ruby %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option window line_comment_token '#'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option window static_words 'attr_reader' 'attr_writer' 'attr_accessor' 'abort' 'abstract' 'alias' 'annotation' 'as' 'as?' 'asm' 'at_exit' 'begin' 'break' 'caller' 'case' 'class' 'class_getter' 'class_getter!' 'class_getter?' 'class_property' 'class_property!' 'class_property?' 'class_setter' 'debugger' 'def' 'def_clone' 'def_equals' 'def_equals_and_hash' 'def_hash' 'delegate' 'do' 'else' 'elsif' 'end' 'ensure' 'enum' 'exit' 'extend' 'false' 'for' 'forward_missing_to' 'fun' 'gets' 'getter' 'getter!' 'getter?' 'if' 'in' 'include' 'instance_sizeof' 'is_a?' 'lib' 'loop' 'macro' 'main' 'module' 'next' 'nil' 'nil?' 'of' 'offsetof' 'out' 'p' 'p!' 'pointerof' 'pp' 'pp!' 'print' 'printf' 'private' 'property' 'property!' 'property?' 'protected' 'puts' 'raise' 'raise_without_backtrace' 'rand' 'read_line' 'record' 'require' 'rescue' 'responds_to?' 'return' 'select' 'self' 'setter' 'sizeof' 'sleep' 'spawn' 'sprintf' 'struct' 'super' 'system' 'then' 'timeout_select_action' 'true' 'type' 'typeof' 'uninitialized' 'union' 'unless' 'until' 'verbatim' 'when' 'while' 'with' 'yield'
  hook -always -once window WinSetOption 'filetype=.*' %{
    unset-option window line_comment_token
    unset-option buffer extra_word_chars
    unset-option window static_words
  }
}

# Indentation ──────────────────────────────────────────────────────────────────

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/ruby regions
add-highlighter shared/ruby/code default-region group

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
# https://github.com/ruby-lang-tools/vscode-ruby-lang/blob/master/syntaxes/ruby.json
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/ruby/code/instance-method-definition regex "\b(def)\h+(%opt{ruby_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/ruby/code/class-method-definition regex "\b(def)\h+(self\.%opt{ruby_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/ruby/code/method-call regex "\b(%opt{ruby_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://ruby-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/ruby/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `ruby-check-news`.
add-highlighter shared/ruby/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `ruby-check-news`.
add-highlighter shared/ruby/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/ruby/code/support.function.object regex '\battr_reader\b|\battr_writer\b|\battr_accessor\b|\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/ruby/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/ruby/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/ruby/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/ruby/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/ruby/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/ruby/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/ruby/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/ruby/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/ruby/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/ruby/comment region '#(?!\{)' '$' group
add-highlighter shared/ruby/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/ruby/comment/reference regex "`[#.]?%opt{ruby_word_pattern}`" 0:mono
add-highlighter shared/ruby/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/ruby/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/ruby/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/ruby/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Ruby raw string.
#
# Syntax:
#
# define-ruby-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-ruby-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list ruby_optional_arguments
define-command -hidden define-ruby-string -params 4.. %{
  set-option global ruby_optional_arguments %arg{@}
  set-option -remove global ruby_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/ruby/%arg{1}" region %opt{ruby_optional_arguments} regions
  add-highlighter "shared/ruby/%arg{1}/content" default-region group
  add-highlighter "shared/ruby/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/ruby/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/ruby/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Ruby string interpolation.
#
# Syntax:
#
# define-ruby-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-ruby-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-ruby-interpolated-string -params 4.. %{
  define-ruby-string %arg{@}
  add-highlighter "shared/ruby/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/ruby/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/ruby/%arg{1}/interpolation/ruby" ref ruby
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/ruby/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/ruby/string/content default-region group
add-highlighter shared/ruby/string/content/fill fill value
add-highlighter shared/ruby/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/ruby/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-ruby-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/ruby/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/ruby/string.interpolated/content default-region group
add-highlighter shared/ruby/string.interpolated/content/fill fill string
add-highlighter shared/ruby/string.interpolated/content/escaped-character ref ruby/string/content/escaped-character
add-highlighter shared/ruby/string.interpolated/content/escape-sequence ref ruby/string/content/escape-sequence
add-highlighter shared/ruby/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/ruby/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/ruby/string.interpolated/interpolation/ruby ref ruby
# define-ruby-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/ruby/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref ruby/string.interpolated
add-highlighter shared/ruby/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref ruby/string.interpolated
add-highlighter shared/ruby/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref ruby/string.interpolated
add-highlighter shared/ruby/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref ruby/string.interpolated
add-highlighter shared/ruby/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref ruby/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/ruby/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref ruby/string
add-highlighter shared/ruby/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref ruby/string
add-highlighter shared/ruby/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref ruby/string
add-highlighter shared/ruby/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref ruby/string
add-highlighter shared/ruby/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref ruby/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/ruby/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref ruby/string.interpolated
add-highlighter shared/ruby/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref ruby/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/ruby/code/constant.symbol regex ":%opt{ruby_word_pattern}" 0:value
add-highlighter shared/ruby/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref ruby/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/ruby/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/ruby/string.regexp.interpolated/content default-region group
add-highlighter shared/ruby/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/ruby/string.regexp.interpolated/content/escaped-character ref ruby/string/content/escaped-character
add-highlighter shared/ruby/string.regexp.interpolated/content/escape-sequence ref ruby/string/content/escape-sequence
add-highlighter shared/ruby/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/ruby/string.regexp.interpolated/interpolation/delimiters ref ruby/string.interpolated/interpolation/delimiters
add-highlighter shared/ruby/string.regexp.interpolated/interpolation/ruby ref ruby

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/ruby/division-as-region region ' //? ' '.\K' group
add-highlighter shared/ruby/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/ruby/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref ruby/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://ruby-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/ruby/string.command region '`' '(?<!\\)(\\\\)*`' ref ruby/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/ruby/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.command.percent.angle region -recurse '<' '%x<' '>' ref ruby/string.regexp.interpolated
add-highlighter shared/ruby/string.command.percent.pipe region '%x\|' '\|' ref ruby/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `ruby-build-result keywords`.
#
define-command -hidden ruby-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug ruby %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug ruby %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden ruby-build-result-with-static-words -params 1 %{
  ruby-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden ruby-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/ruby-lang/ruby/blob/master/src/compiler/ruby/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/ruby-lang/ruby/raw/master/src/compiler/ruby/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{ruby_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{ruby_word_pattern}<a-!>)<ret><a-z>a'
  ruby-build-result-with-static-words keywords

  # Top Level Namespace
  # https://ruby-lang.org/api/master/toplevel.html#method-summary
  # https://ruby-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://ruby-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{ruby_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  ruby-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://ruby-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://ruby-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{ruby_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  ruby-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  ruby-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
