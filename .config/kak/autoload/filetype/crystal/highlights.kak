# What’s new
# Reference
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://crystal-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module JSON
# end
#
# private module JSON
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://crystal-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Creates the base regions
add-highlighter shared/crystal regions
add-highlighter shared/crystal/code default-region group

# Comments
add-highlighter shared/crystal.comment regions
add-highlighter shared/crystal.comment/comment default-region group
add-highlighter shared/crystal.comment/comment/ fill comment

# Escape sequences
add-highlighter shared/crystal.escape_sequence regions
add-highlighter shared/crystal.escape_sequence/escape_sequence default-region group
add-highlighter shared/crystal.escape_sequence/escape_sequence/ fill string
add-highlighter shared/crystal.escape_sequence/escape_sequence/ regex '\\[abefnrtv]|\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:value

# Strings
add-highlighter shared/crystal.string regions
add-highlighter shared/crystal.string/string default-region group
add-highlighter shared/crystal.string/string/ fill string
add-highlighter shared/crystal.string/string/ ref crystal.escape_sequence

# Interpolated strings
add-highlighter shared/crystal.string.interpolated regions
add-highlighter shared/crystal.string.interpolated/string default-region group
add-highlighter shared/crystal.string.interpolated/string/ fill string
add-highlighter shared/crystal.string.interpolated/string/ ref crystal.escape_sequence
add-highlighter shared/crystal.string.interpolated/ region -recurse '\{' '\$\{\K' '(?=\})' ref crystal

# Regular expressions
add-highlighter shared/crystal.regexp regions
add-highlighter shared/crystal.regexp/regexp default-region group
add-highlighter shared/crystal.regexp/regexp/ fill meta

# Syntax and semantics
# Method definition and call
# https://crystal-lang.org/reference/master/syntax_and_semantics/method_arguments.html
add-highlighter shared/crystal/code/instance_method_name_declaration regex '\bdef\h+\K(?:\w+\.|\w+::)*\w+[?!]?' 0:function
add-highlighter shared/crystal/code/method_name_call regex '\b(?:\w+\.|\w+::)*\w+[?!]?(?=\()' 0:function

# Keywords
# https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/lexer.cr
add-highlighter shared/crystal/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions
# Top Level Namespace
# https://crystal-lang.org/api/master/toplevel.html
add-highlighter shared/crystal/code/support.function.kernel.top_level_namespace regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin

# Object macros
# https://crystal-lang.org/api/master/Object.html
add-highlighter shared/crystal/code/support.function.object.object_macros regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Operators
add-highlighter shared/crystal/code/operator regex '[-+*/%^&!?@|<>=:(){}[\];:,.]' 0:operator

# Literals
add-highlighter shared/crystal/code/literal regex '\bthis\b|\bundefined\b|\bdocument\b|\bwindow\b|\bfalse\b|\btrue\b|\bnull\b|\b_G\b|\b_ENV\b|\d[\d_]*\.\w[\w]*|\d[\w]*|\b[A-Z]\w*\b' 0:value

# Comments
add-highlighter shared/crystal/comment region '//' '$' ref crystal.comment

# Single quoted strings
add-highlighter shared/crystal/string.quoted.single region "'" "(?<!\\)(?:\\\\)*'" group
add-highlighter shared/crystal/string.quoted.single/escaping ref crystal.string
add-highlighter shared/crystal/string.quoted.single/escaped regex "\\'" 0:value

# Double quoted strings
add-highlighter shared/crystal/string.quoted.double region '"' '(?<!\\)(?:\\\\)*"' group
add-highlighter shared/crystal/string.quoted.double/escaping ref crystal.string
add-highlighter shared/crystal/string.quoted.double/escaped regex '\\"' 0:value

# Template strings
add-highlighter shared/crystal/string.quoted.template region '`' '(?<!\\)(?:\\\\)*`' group
add-highlighter shared/crystal/string.quoted.template/interpolated ref crystal.string.interpolated
add-highlighter shared/crystal/string.quoted.template/escaped regex '\\`' 0:value

# Regular expressions
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
add-highlighter shared/crystal/string.quoted.regexp region '/\H' '(?<!\\)(?:\\\\)*/[imsdguy]*' group
add-highlighter shared/crystal/string.quoted.regexp/regexp ref crystal.regexp
add-highlighter shared/crystal/string.quoted.regexp/escaped regex '\\/' 0:value
###########################################################################################################
# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/

# Instance and class variables

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/crystal/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Punctuation

# punctuation.separator
add-highlighter shared/crystal/code/punctuation.separator regex '\.|::' 0:meta

# Operators

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/crystal/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/crystal/code/operator.range regex '\.\.\.?' 0:operator

# Constants

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/crystal/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/crystal/code/constant.numeric.integer.decimal regex '\b[+-]?\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/crystal/code/constant.numeric.float.decimal regex '\b[+-]?\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/crystal/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/crystal/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/crystal/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/crystal/comment region '#(?!\{)' '$' group
add-highlighter shared/crystal/comment/fill fill comment

# Documenting code

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/crystal/comment/reference regex "`[#.]?\w+[?!]?`" 0:mono
add-highlighter shared/crystal/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/crystal/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/crystal/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/crystal/comment/directive regex ':\w+:' 0:meta

# Interpolation

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Characters

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/crystal/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/crystal/string/content default-region group
add-highlighter shared/crystal/string/content/fill fill value
add-highlighter shared/crystal/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/crystal/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta

# Strings

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/crystal/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/crystal/string.interpolated/content default-region group
add-highlighter shared/crystal/string.interpolated/content/fill fill string
add-highlighter shared/crystal/string.interpolated/content/escaped-character ref crystal/string/content/escaped-character
add-highlighter shared/crystal/string.interpolated/content/escape-sequence ref crystal/string/content/escape-sequence
add-highlighter shared/crystal/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/crystal/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/crystal/string.interpolated/interpolation/crystal ref crystal
# define-crystal-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/crystal/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref crystal/string.interpolated
add-highlighter shared/crystal/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref crystal/string.interpolated
add-highlighter shared/crystal/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref crystal/string.interpolated
add-highlighter shared/crystal/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref crystal/string.interpolated
add-highlighter shared/crystal/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref crystal/string.interpolated

# Raw percent string literals

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/crystal/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref crystal/string
add-highlighter shared/crystal/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref crystal/string
add-highlighter shared/crystal/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref crystal/string
add-highlighter shared/crystal/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref crystal/string
add-highlighter shared/crystal/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref crystal/string

# Here document

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/crystal/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref crystal/string.interpolated
add-highlighter shared/crystal/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref crystal/string

# Symbols

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/crystal/code/constant.symbol regex ":\w+[?!]?" 0:value
add-highlighter shared/crystal/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref crystal/string

# Regular expressions

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/crystal/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/crystal/string.regexp.interpolated/content default-region group
add-highlighter shared/crystal/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/crystal/string.regexp.interpolated/content/escaped-character ref crystal/string/content/escaped-character
add-highlighter shared/crystal/string.regexp.interpolated/content/escape-sequence ref crystal/string/content/escape-sequence
add-highlighter shared/crystal/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/crystal/string.regexp.interpolated/interpolation/delimiters ref crystal/string.interpolated/interpolation/delimiters
add-highlighter shared/crystal/string.regexp.interpolated/interpolation/crystal ref crystal

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/crystal/division-as-region region ' //? ' '.\K' group
add-highlighter shared/crystal/division-as-region/operator regex '//?' 0:operator

# Percent regex literals

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/crystal/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref crystal/string.regexp.interpolated

# Command literal

# Reference
# https://crystal-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/crystal/string.command region '`' '(?<!\\)(\\\\)*`' ref crystal/string.regexp.interpolated

# Percent command literals

# Example:
#
# %x(echo foo)
#
add-highlighter shared/crystal/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.command.percent.angle region -recurse '<' '%x<' '>' ref crystal/string.regexp.interpolated
add-highlighter shared/crystal/string.command.percent.pipe region '%x\|' '\|' ref crystal/string.regexp.interpolated
###########################################################################################################
