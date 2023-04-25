# CSS
# https://css.org

# kakoune-css
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [CSS] programming language.

# [Kakoune]: https://kakoune.org
# [CSS]: https://css-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'CSS word pattern' str css_word_pattern '\w+[?!]?'

# Reference
#
# https://css-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://css-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://css-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://css-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://css-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://css-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module CSS
# end
#
# private module CSS
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://css-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://css-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://css-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets CSS filetype when opening `.css` files.
remove-hooks global css-detection
hook -group css-detection global BufCreate '.+\.css' %{
  set-option buffer filetype css
}

# Enables syntax highlighting for CSS filetype.
remove-hooks global css-highlight
hook -group css-highlight global WinSetOption filetype=css %{
  add-highlighter window/css ref css
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/css
  }
}

# Configures word selection and completion for CSS filetype.
# `static_words` option is generated with `css-check-news`.
remove-hooks global css-config
hook -group css-config global WinSetOption filetype=css %{
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
add-highlighter shared/css regions
add-highlighter shared/css/code default-region group

# TODO
# syntax "**/*.css"
# syntax keywords ""
# syntax types "@{%w_-}"
# syntax symbols "%(|%)|%{|%}|%[|%]|<|>|*|:|;|,"
# syntax literals "%d{%d_}%.%w{%w%%_}|%d{%w%%_}"
# syntax strings {"{(\\)(\")!".}}
# syntax comments "/*{!(*/).$}"
# syntax texts "{%w_-}"
add-highlighter shared/css/attr_selector region \[ \] regions
add-highlighter shared/css/double_string region '"'  (?<!\\)(\\\\)*" fill string
add-highlighter shared/css/single_string region "'"  (?<!\\)(\\\\)*' fill string
add-highlighter shared/css/comment2    region /\* \*/ fill comment
# https://developer.mozilla.org/en-US/docs/Web/HTML/Element
# https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Values_and_Units
# combinators='+ > ~ ||'
# attribute_op='= ~= |= ^= $= *='
# Selectors
# universal: *, ns|*, *|*, |*
# class/id: .class, #id
# type: element
# attr: [attr=val]
# order below matters
add-highlighter shared/css/code/tag_selectors regex \b(html|body|address|article|aside|footer|header|h1|h2|h3|h4|h5|h6|main|nav|section|blockquote|dd|div|dl|dt|figcaption|figure|hr|li|ol|p|pre|ul|a|abbr|b|bdi|bdo|br|cite|code|data|dfn|em|i|kbd|mark|q|rp|rt|ruby|s|samp|small|span|strong|sub|sup|time|u|var|wbr|area|audio|img|map|track|video|embed|iframe|object|param|picture|portal|source|canvas|noscript|script|del|ins|caption|col|colgroup|table|tbody|td|tfoot|th|thead|tr|button|datalist|fieldset|form|input|label|legend|meter|optgroup|option|output|progress|select|textarea|details|dialog|menu|summary|slot|template|acronym|applet|basefont|bgsound|big|blink|center|content|dir|font|frame|frameset|hgroup|image|keygen|marquee|menuitem|nobr|noembed|noframes|plaintext|rb|rtc|shadow|spacer|strike|tt|xmp)((:[a-z:])|[\h.#,]) 1:keyword
add-highlighter shared/css/code/functional_notation regex ([a-zA-Z0-9-_]+[a-zA-Z0-9])\( 1:keyword
add-highlighter shared/css/code/logical_operators regex (\b(and|not|only|from|to)\b|!important|auto|inherit|initial|unset|none) 1:cssLogicalOperator
add-highlighter shared/css/code/media_types regex \b(all|print|screen|speech)\b 1:+i
# (after functional notation as they may contain paranthesis)
add-highlighter shared/css/code/pseudo regex (:{1,2})([a-z-]+) 0:attribute
add-highlighter shared/css/code/at_rules regex @[a-z-]+ 0:function 
add-highlighter shared/css/code/css_property regex ([A-Za-z][A-Za-z0-9_-]*)\h*:\h 1:operator 1:+a
add-highlighter shared/css/code/selectors regex (\*|[*]?[.][A-Za-z][A-Za-z0-9_-]+) 0:type
add-highlighter shared/css/code/selectors_id regex (\*|[*]?[#][A-Za-z][A-Za-z0-9_-]+) 0:type 0:+i
add-highlighter shared/css/code/hex_values regex (#[0-9A-Fa-f]{3,8})\b 0:value 0:+a
add-highlighter shared/css/code/units regex \b(\d*\.)?\d+(%|cap|ch|cm|deg|dpcm|dpi|dppx|em|ex|grad|Hz|ic|in|kHz|lh|mm|ms|pc|pt|px|Q|rad|rem|rlh|s|turn|vb|vh|vi|vmax|vmin|vw|x)?\b 0:value 0:+a
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
# https://github.com/css-lang-tools/vscode-css-lang/blob/master/syntaxes/css.css
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/css/code/instance-method-definition regex "\b(def)\h+(%opt{css_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/css/code/class-method-definition regex "\b(def)\h+(self\.%opt{css_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/css/code/method-call regex "\b(%opt{css_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://css-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/css/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `css-check-news`.
add-highlighter shared/css/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `css-check-news`.
add-highlighter shared/css/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/css/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/css/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/css/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/css/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/css/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://css-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/css/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/css/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/css/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/css/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/css/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/css/comment region '#(?!\{)' '$' group
add-highlighter shared/css/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/css/comment/reference regex "`[#.]?%opt{css_word_pattern}`" 0:mono
add-highlighter shared/css/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/css/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/css/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/css/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines CSS raw string.
#
# Syntax:
#
# define-css-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-css-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list css_optional_arguments
define-command -hidden define-css-string -params 4.. %{
  set-option global css_optional_arguments %arg{@}
  set-option -remove global css_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/css/%arg{1}" region %opt{css_optional_arguments} regions
  add-highlighter "shared/css/%arg{1}/content" default-region group
  add-highlighter "shared/css/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/css/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/css/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines CSS string interpolation.
#
# Syntax:
#
# define-css-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-css-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-css-interpolated-string -params 4.. %{
  define-css-string %arg{@}
  add-highlighter "shared/css/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/css/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/css/%arg{1}/interpolation/css" ref css
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/css/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/css/string/content default-region group
add-highlighter shared/css/string/content/fill fill value
add-highlighter shared/css/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/css/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-css-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/css/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/css/string.interpolated/content default-region group
add-highlighter shared/css/string.interpolated/content/fill fill string
add-highlighter shared/css/string.interpolated/content/escaped-character ref css/string/content/escaped-character
add-highlighter shared/css/string.interpolated/content/escape-sequence ref css/string/content/escape-sequence
add-highlighter shared/css/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/css/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/css/string.interpolated/interpolation/css ref css
# define-css-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/css/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref css/string.interpolated
add-highlighter shared/css/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref css/string.interpolated
add-highlighter shared/css/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref css/string.interpolated
add-highlighter shared/css/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref css/string.interpolated
add-highlighter shared/css/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref css/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://css-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/css/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref css/string
add-highlighter shared/css/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref css/string
add-highlighter shared/css/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref css/string
add-highlighter shared/css/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref css/string
add-highlighter shared/css/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref css/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/css/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref css/string.interpolated
add-highlighter shared/css/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref css/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/css/code/constant.symbol regex ":%opt{css_word_pattern}" 0:value
add-highlighter shared/css/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref css/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/css/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/css/string.regexp.interpolated/content default-region group
add-highlighter shared/css/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/css/string.regexp.interpolated/content/escaped-character ref css/string/content/escaped-character
add-highlighter shared/css/string.regexp.interpolated/content/escape-sequence ref css/string/content/escape-sequence
add-highlighter shared/css/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/css/string.regexp.interpolated/interpolation/delimiters ref css/string.interpolated/interpolation/delimiters
add-highlighter shared/css/string.regexp.interpolated/interpolation/css ref css

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/css/division-as-region region ' //? ' '.\K' group
add-highlighter shared/css/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/css/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref css/string.regexp.interpolated
add-highlighter shared/css/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref css/string.regexp.interpolated
add-highlighter shared/css/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref css/string.regexp.interpolated
add-highlighter shared/css/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref css/string.regexp.interpolated
add-highlighter shared/css/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref css/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://css-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/css/string.command region '`' '(?<!\\)(\\\\)*`' ref css/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/css/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref css/string.regexp.interpolated
add-highlighter shared/css/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref css/string.regexp.interpolated
add-highlighter shared/css/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref css/string.regexp.interpolated
add-highlighter shared/css/string.command.percent.angle region -recurse '<' '%x<' '>' ref css/string.regexp.interpolated
add-highlighter shared/css/string.command.percent.pipe region '%x\|' '\|' ref css/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `css-build-result keywords`.
#
define-command -hidden css-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug css %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug css %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden css-build-result-with-static-words -params 1 %{
  css-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden css-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/css-lang/css/blob/master/src/compiler/css/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/css-lang/css/raw/master/src/compiler/css/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{css_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{css_word_pattern}<a-!>)<ret><a-z>a'
  css-build-result-with-static-words keywords

  # Top Level Namespace
  # https://css-lang.org/api/master/toplevel.html#method-summary
  # https://css-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://css-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{css_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  css-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://css-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://css-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{css_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  css-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  css-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
