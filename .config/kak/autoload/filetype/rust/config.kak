# Rust
# https://rust.org

# kakoune-rust
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [Rust] programming language.

# [Kakoune]: https://kakoune.org
# [Rust]: https://rust-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'Rust word pattern' str rust_word_pattern '\w+[?!]?'

# Reference
#
# https://rust-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://rust-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://rust-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://rust-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://rust-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://rust-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module Rust
# end
#
# private module Rust
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://rust-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://rust-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://rust-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets Rust filetype when opening `.rs` files.
remove-hooks global rust-detection
hook -group rust-detection global BufCreate '.+\.rs' %{
  set-option buffer filetype rust
}

# Enables syntax highlighting for Rust filetype.
remove-hooks global rust-highlight
hook -group rust-highlight global WinSetOption filetype=rust %{
  add-highlighter window/rust ref rust
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/rust
  }
}

# Configures word selection and completion for Rust filetype.
# `static_words` option is generated with `rust-check-news`.
remove-hooks global rust-config
hook -group rust-config global WinSetOption filetype=rust %{
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
add-highlighter shared/rust regions
add-highlighter shared/rust/code default-region group

# TODO
# # https://doc.rust-lang.org/reference/keywords.html
# syntax "**/*.rs"
# syntax keywords as|break|const|continue|crate|else|enum|extern|fn|for|if|impl|in|let|loop|match|mod|move|mut|pub|ref|return|static|struct|super|trait|type|unsafe|use|where|while|async|await|dyn|abstract|become|box|do|final|macro|override|priv|typeof|unsized|virtual|yield|try|union
# syntax types "bool|u8|u16|u32|u64|usize|i8|i16|i32|i64|isize|f32|f64|str|char|%u{%w_}"
# syntax symbols "%(|%)|%[|%]|%{|%}|%.|:|;|,|=|<|>|+|-|/|*|%%|%!|?|&|%||@"
# syntax literals "true|false|self|'\\''|'\\{!'.}|'.'|b'{(\\')(\\\\)!'.}|%d{%d_}%.%w{%w_}|%d{%w_}|'%a{%w_}"
# syntax strings '"{(\\\\)(\\")!".}|b"{(\\\\)(\\")!".}'
# syntax comments "//{.}|/*{!(*/).$}"
# add-highlighter shared/rust/string           region %{(?<!')"} (?<!\\)(\\\\)*"              fill string
add-highlighter shared/rust/raw_string       region -match-capture %{(?<!')r(#*)"} %{"(#*)} fill string
add-highlighter shared/rust/line_doctest region ^\h*//[!/]\h*```($|should_panic|no_run|ignore|allow_fail|rust|test_harness|compile_fail|E\d{4}|edition201[58]) ^\h*//[!/]\h*```$ regions
add-highlighter shared/rust/line_doctest/marker region ``` $ group
add-highlighter shared/rust/line_doctest/marker/fence regex ``` 0:meta
add-highlighter shared/rust/line_doctest/marker/keywords regex [\d\w] 0:meta # already matched above, just ignore comma
add-highlighter shared/rust/line_doctest/inner region '^\h*//[!/]( #(?= ))?' '$| ' group
add-highlighter shared/rust/line_doctest/inner/comment regex //[!/] 0:documentation
add-highlighter shared/rust/line_doctest/inner/hidden regex '#' 0:meta
add-highlighter shared/rust/line_doctest/code default-region ref rust
add-highlighter shared/rust/line_code_rest   region ^\h*//[!/]\h*``` ^\h*//[!/]\h*```$      fill documentation # reset invalid doctest
add-highlighter shared/rust/line_comment2    region //[!/]{2} $                             fill comment
add-highlighter shared/rust/line_doc         region //[!/] $                                fill documentation
add-highlighter shared/rust/line_comment1    region // $                                    group
add-highlighter shared/rust/line_comment1/comment fill comment
add-highlighter shared/rust/line_comment1/todo regex (TODO|NOTE|FIXME): 1:meta
add-highlighter shared/rust/block_comment2   region -recurse /\*\*\* /\*\*\* \*/            fill comment
add-highlighter shared/rust/block_doc        region -recurse /\*\* /\*\* \*/ regions
add-highlighter shared/rust/block_doc/doctest region ```($|should_panic|no_run|ignore|allow_fail|rust|test_harness|compile_fail|E\d{4}|edition201[58]) ```$ regions
add-highlighter shared/rust/block_doc/doctest/marker region ``` $ group
add-highlighter shared/rust/block_doc/doctest/marker/fence regex ``` 0:meta
add-highlighter shared/rust/block_doc/doctest/marker/keywords regex [\d\w] 0:meta # already matched above, just ignore comma
add-highlighter shared/rust/block_doc/doctest/inner default-region group
add-highlighter shared/rust/block_doc/doctest/inner/hidden regex '^\h*\**\h*#' 0:meta
add-highlighter shared/rust/block_doc/doctest/inner/comment regex ^\h*\* 0:documentation
add-highlighter shared/rust/block_doc/doctest/inner/code ref rust
add-highlighter shared/rust/block_doc/code_rest region ``` ``` fill documentation
add-highlighter shared/rust/block_doc/doc    default-region fill documentation
add-highlighter shared/rust/block_comment1   region -recurse /\* /\* \*/ group
add-highlighter shared/rust/block_comment1/comment fill comment
add-highlighter shared/rust/block_comment1/todo regex (TODO|NOTE|FIXME): 1:meta
add-highlighter shared/rust/macro_attributes region -recurse "\[" "#!?\[" "\]" regions
add-highlighter shared/rust/macro_attributes/ default-region fill meta
add-highlighter shared/rust/macro_attributes/string region %{(?<!')"} (?<!\\)(\\\\)*" fill string
add-highlighter shared/rust/macro_attributes/raw_string region -match-capture %{(?<!')r(#*)"} %{"(#*)} fill string
add-highlighter shared/rust/code/operators_arithmetic   regex (\+|-|/|\*|=|\^|&|\||!|>|<|%)=? 0:operator
add-highlighter shared/rust/code/operators_as           regex \bas\b 0:operator
add-highlighter shared/rust/code/ref_ref                regex (&\h+[&~@*])[^)=\s\t\r\n] 1:type
add-highlighter shared/rust/code/ref                    regex ([&~@*])[^)=\s\t\r\n] 1:type
add-highlighter shared/rust/code/operators_logic        regex &&|\|\| 0:operator
add-highlighter shared/rust/code/lifetime_or_loop_label regex ('([a-zA-Z]\w+|_\w+))\b 1:meta
add-highlighter shared/rust/code/namespace              regex \b[a-zA-Z](\w+)?(\h+)?(?=::) 0:module
add-highlighter shared/rust/code/mod_path_sep           regex :: 0:meta
add-highlighter shared/rust/code/question_mark          regex \? 0:meta
# the language keywords are defined here, but many of   them are reserved and unused yet:
# https://doc.rust-lang.org/reference/keywords.html
add-highlighter shared/rust/code/function_call          regex _?[a-zA-Z]\w*\s*(?=\() 0:function
add-highlighter shared/rust/code/generic_function_call  regex _?[a-zA-Z]\w*\s*(?=::<) 0:function
add-highlighter shared/rust/code/function_declaration   regex (?:fn\h+)(_?\w+)(?:<[^>]+?>)?\( 1:function
add-highlighter shared/rust/code/keywords               regex \b(?:as|break|continue|crate|else|enum|extern|false|fn|for|if|impl|in|let|loop|match|mod|pub|return|self|Self|struct|super|trait|true|type|union|unsafe|use|where|while|async|await|dyn|abstract|become|box|do|try)\b 0:keyword
add-highlighter shared/rust/code/storage                regex \b(move|mut|ref|static|const)\b 0:type
add-highlighter shared/rust/code/pub_with_scope         regex \b(pub)\h*(\()\h*(crate|super|self|in\h+[\w:]+)\h*(\)) 1:keyword 2:meta 4:meta
# after let can be an arbitrary pattern match
add-highlighter shared/rust/code/macro                  regex \b\w+! 0:meta
# the number literals syntax is defined here:
# https://doc.rust-lang.org/reference/tokens.html#numb  ers
add-highlighter shared/rust/code/values                 regex \b(?:self|true|false|[0-9][_0-9]*(?:\.[0-9][_0-9]*|(?:\.[0-9][_0-9]*)?E[\+\-][_0-9]+)(?:f(?:32|64))?|(?:0x[_0-9a-fA-F]+|0o[_0-7]+|0b[_01]+|[0-9][_0-9]*)(?:(?:i|u|f)(?:8|16|32|64|128|size))?)\b 0:value
add-highlighter shared/rust/code/char_character         regex "'([^\\]|\\(.|x[0-9a-fA-F]{2}|u\{[0-9a-fA-F]{1,6}\}))'" 0:green
# TODO highlight error for unicode or single escape by  te character
add-highlighter shared/rust/code/byte_character         regex b'([\x00-\x5B\x5D-\x7F]|\\(.|x[0-9a-fA-F]{2}))' 0:yellow
add-highlighter shared/rust/code/builtin_types          regex \b(?:u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize|f32|f64|bool|char|str|Self)\b 0:type
add-highlighter shared/rust/code/return                 regex \breturn\b 0:meta
add-highlighter shared/rust/code/enum                   regex \b(Option|Result)\b 0:type
add-highlighter shared/rust/code/enum_variant           regex \b(Some|None|Ok|Err)\b 0:value
add-highlighter shared/rust/code/std_traits             regex \b(Copy|Send|Sized|Sync|Drop|Fn|FnMut|FnOnce|Box|ToOwned|Clone|PartialEq|PartialOrd|Eq|Ord|AsRef|AsMut|Into|From|Default|Iterator|Extend|IntoIterator|DoubleEndedIterator|ExactSizeIterator|SliceConcatExt|String|ToString|Vec)\b 0:type
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
# https://github.com/rust-lang-tools/vscode-rust-lang/blob/master/syntaxes/rust.rust
# https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide
# https://sublimetext.com/docs/scope_naming.html

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/

# Method definition and call ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/method_arguments.html

add-highlighter shared/rust/code/instance-method-definition regex "\b(def)\h+(%opt{rust_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/rust/code/class-method-definition regex "\b(def)\h+(self\.%opt{rust_word_pattern})\b" 1:keyword 2:function
add-highlighter shared/rust/code/method-call regex "\b(%opt{rust_word_pattern})\(" 1:function

# Instance and class variables ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/methods_and_instance_variables.html
# https://rust-lang.org/reference/master/syntax_and_semantics/class_variables.html

add-highlighter shared/rust/code/instance-and-class-variables regex '@@?\w+\b' 0:variable

# Keywords ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `rust-check-news`.
add-highlighter shared/rust/code/keyword regex '\binstance_sizeof\b|\buninitialized\b|\bresponds_to\?|\bannotation\b|\bprotected\b|\bpointerof\b|\bverbatim\b|\boffsetof\b|\babstract\b|\brequire\b|\bprivate\b|\binclude\b|\bunless\b|\btypeof\b|\bstruct\b|\bsizeof\b|\bselect\b|\breturn\b|\brescue\b|\bmodule\b|\bextend\b|\bensure\b|\byield\b|\bwhile\b|\buntil\b|\bunion\b|\bsuper\b|\bmacro\b|\bis_a\?|\bfalse\b|\belsif\b|\bclass\b|\bbreak\b|\bbegin\b|\balias\b|\bwith\b|\bwhen\b|\btype\b|\btrue\b|\bthen\b|\bself\b|\bnil\?|\bnext\b|\benum\b|\belse\b|\bcase\b|\bout\b|\bnil\b|\blib\b|\bfun\b|\bfor\b|\bend\b|\bdef\b|\basm\b|\bas\?|\bof\b|\bin\b|\bif\b|\bdo\b|\bas\b' 0:keyword

# Built-in functions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Note:
# Generated with `rust-check-news`.
add-highlighter shared/rust/code/support.function.kernel regex '\braise_without_backtrace\b|\btimeout_select_action\b|\binstance_sizeof\b|\bread_line\b|\bpointerof\b|\boffsetof\b|\bdebugger\b|\bsprintf\b|\bat_exit\b|\btypeof\b|\bsystem\b|\bsizeof\b|\brecord\b|\bprintf\b|\bcaller\b|\bspawn\b|\bsleep\b|\braise\b|\bprint\b|\babort\b|\brand\b|\bputs\b|\bmain\b|\bloop\b|\bgets\b|\bexit\b|\bpp!|\bpp\b|\bp!|\bp\b' 0:builtin
add-highlighter shared/rust/code/support.function.object regex '\bdef_equals_and_hash\b|\bforward_missing_to\b|\bclass_property\?|\bclass_property!|\bclass_property\b|\bclass_getter\?|\bclass_getter!|\bclass_setter\b|\bclass_getter\b|\bdef_equals\b|\bproperty\?|\bproperty!|\bdef_clone\b|\bproperty\b|\bdelegate\b|\bdef_hash\b|\bgetter\?|\bgetter!|\bsetter\b|\bgetter\b' 0:builtin

# Punctuation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# punctuation.separator
add-highlighter shared/rust/code/punctuation.separator regex '\.|::' 0:meta

# Operators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/operators.html

add-highlighter shared/rust/code/operator regex '[!%&*+/<=>^|~-]' 0:operator
add-highlighter shared/rust/code/operator.range regex '\.\.\.?' 0:operator

# Constants ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/constants.html

add-highlighter shared/rust/code/variable.constant regex '\b[A-Z]\w*\b' 0:value

# Numbers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/integers.html
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/floats.html

# Examples:
#
# decimal number ⇒ 1_000_000
# float number ⇒ 1_000_000.111_111
#
add-highlighter shared/rust/code/constant.numeric.integer.decimal regex '\b\d(_?\d+)*(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/rust/code/constant.numeric.float.decimal regex '\b\d(_?\d+)*\.\d(_?\d+)*(_(f32|f64))?\b' 0:value

# Examples:
#
# binary number ⇒ 0b1101
# octal number ⇒ 0o123
# hexadecimal number ⇒ 0xfe012d
#
add-highlighter shared/rust/code/constant.numeric.integer.binary regex '\b0b[0-1]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/rust/code/constant.numeric.integer.octal regex '\b0o[0-7]+(_[iu](8|16|32|64|128))?\b' 0:value
add-highlighter shared/rust/code/constant.numeric.integer.hexadecimal regex '\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b' 0:value

# Comments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/comments.html

# Note: Avoid string literals with interpolation.
#
# Example:
#
# puts "hello #{name}"
#
add-highlighter shared/rust/comment region '#(?!\{)' '$' group
add-highlighter shared/rust/comment/fill fill comment

# Documenting code ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/documenting_code.html

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
add-highlighter shared/rust/comment/reference regex "`[#.]?%opt{rust_word_pattern}`" 0:mono
add-highlighter shared/rust/comment/parameter regex '\*\w+\*' 0:mono
add-highlighter shared/rust/comment/code-block regex '```(\h*\w+)?$' 0:block
add-highlighter shared/rust/comment/admonition regex '\h+([A-Z]+):\h+' 1:meta
add-highlighter shared/rust/comment/directive regex ':\w+:' 0:meta

# Interpolation ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#interpolation
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#escaping

# Defines Rust raw string.
#
# Syntax:
#
# define-rust-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-rust-string raw-parenthesis-string string -recurse '\(' '%q\(' '\)'
#
# puts %q(hello world)
#
declare-option -hidden str-list rust_optional_arguments
define-command -hidden define-rust-string -params 4.. %{
  set-option global rust_optional_arguments %arg{@}
  set-option -remove global rust_optional_arguments %arg{1} %arg{2}
  add-highlighter "shared/rust/%arg{1}" region %opt{rust_optional_arguments} regions
  add-highlighter "shared/rust/%arg{1}/content" default-region group
  add-highlighter "shared/rust/%arg{1}/content/fill" fill %arg{2}
  add-highlighter "shared/rust/%arg{1}/content/escaped-character" regex '\\.' 0:meta
  add-highlighter "shared/rust/%arg{1}/content/escape-sequence" regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
}

# Defines Rust string interpolation.
#
# Syntax:
#
# define-rust-interpolated-string <region-name> <face-name> [<region-switches>] <opening-pattern> <closing-pattern>
#
# Example:
#
# define-rust-interpolated-string parenthesis-string string -recurse '\(' '%\(' '\)'
#
# name = "world"
# puts %(hello #{name})
#
define-command -hidden define-rust-interpolated-string -params 4.. %{
  define-rust-string %arg{@}
  add-highlighter "shared/rust/%arg{1}/interpolation" region -recurse '\{' '#\{' '\}' group # }
  add-highlighter "shared/rust/%arg{1}/interpolation/delimiters" regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
  add-highlighter "shared/rust/%arg{1}/interpolation/rust" ref rust
}

# Characters ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/char.html

# Examples:
#
# simple character ⇒ 'a'
# single quote ⇒ '\''
# backslash ⇒ '\\'
#
add-highlighter shared/rust/string region "'" "(?<!\\)(\\\\)*'" regions
add-highlighter shared/rust/string/content default-region group
add-highlighter shared/rust/string/content/fill fill value
add-highlighter shared/rust/string/content/escaped-character regex '\\.' 0:meta
add-highlighter shared/rust/string/content/escape-sequence regex '\\(x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|u\{[0-9a-fA-F]+\})' 0:meta
# define-rust-string string.character value "'" "(?<!\\)(\\\\)*'"

# Strings ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html

# String literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Examples:
#
# simple string ⇒ "hello world"
# double quote ⇒ "\""
# backslash ⇒ "\\"
#
add-highlighter shared/rust/string.interpolated region '"' '(?<!\\)(\\\\)*"' regions
add-highlighter shared/rust/string.interpolated/content default-region group
add-highlighter shared/rust/string.interpolated/content/fill fill string
add-highlighter shared/rust/string.interpolated/content/escaped-character ref rust/string/content/escaped-character
add-highlighter shared/rust/string.interpolated/content/escape-sequence ref rust/string/content/escape-sequence
add-highlighter shared/rust/string.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/rust/string.interpolated/interpolation/delimiters regex '(?<opening>..).+(?<closing>.)' opening:meta closing:meta
add-highlighter shared/rust/string.interpolated/interpolation/rust ref rust
# define-rust-interpolated-string string.quoted.double string '"' '(?<!\\)(\\\\)*"'

# Percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals

# Example:
#
# name = "world"
# puts %Q(hello #{name})
#
add-highlighter shared/rust/string.quoted.percent.parenthesis.interpolated region -recurse '\(' '%Q?\(' '\)' ref rust/string.interpolated
add-highlighter shared/rust/string.quoted.percent.bracket.interpolated region -recurse '\[' '%Q?\[' '\]' ref rust/string.interpolated
add-highlighter shared/rust/string.quoted.percent.brace.interpolated region -recurse '\{' '%Q?\{' '\}' ref rust/string.interpolated
add-highlighter shared/rust/string.quoted.percent.angle.interpolated region -recurse '<' '%Q?<' '>' ref rust/string.interpolated
add-highlighter shared/rust/string.quoted.percent.pipe.interpolated region '%Q?\|' '\|' ref rust/string.interpolated

# Raw percent string literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-literals
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#percent-string-array-literal
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/symbol.html#percent-symbol-array-literal

# Example:
#
# puts %q(hello world)
#
add-highlighter shared/rust/string.quoted.percent.parenthesis region -recurse '\(' '%[qwi]\(' '\)' ref rust/string
add-highlighter shared/rust/string.quoted.percent.bracket region -recurse '\[' '%[qwi]\[' '\]' ref rust/string
add-highlighter shared/rust/string.quoted.percent.brace region -recurse '\{' '%[qwi]\{' '\}' ref rust/string
add-highlighter shared/rust/string.quoted.percent.angle region -recurse '<' '%[qwi]<' '>' ref rust/string
add-highlighter shared/rust/string.quoted.percent.pipe region '%[qwi]\|' '\|' ref rust/string

# Here document ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/string.html#heredoc

# Example:
#
# <<-'EOF'
# EOF
#
add-highlighter shared/rust/string.unquoted.heredoc.interpolated region -match-capture '<<-(\w+)' '^\h*(\w+)$' ref rust/string.interpolated
add-highlighter shared/rust/string.unquoted.heredoc.raw region -match-capture "<<-'(\w+)'" '^\h*(\w+)$' ref rust/string

# Symbols ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/symbol.html

# Symbol literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# :"quoted symbol"
#
add-highlighter shared/rust/code/constant.symbol regex ":%opt{rust_word_pattern}" 0:value
add-highlighter shared/rust/string.symbol region ':"' '(?<!\\)(\\\\)*"' ref rust/string

# Regular expressions ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/regex.html

# Regex literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# /foo/i.match("FOO")
#
add-highlighter shared/rust/string.regexp.interpolated region '/' '(?<!\\)(\\\\)*/[imx]*' regions
add-highlighter shared/rust/string.regexp.interpolated/content default-region group
add-highlighter shared/rust/string.regexp.interpolated/content/fill fill meta
add-highlighter shared/rust/string.regexp.interpolated/content/escaped-character ref rust/string/content/escaped-character
add-highlighter shared/rust/string.regexp.interpolated/content/escape-sequence ref rust/string/content/escape-sequence
add-highlighter shared/rust/string.regexp.interpolated/interpolation region -recurse '\{' '#\{' '\}' group
add-highlighter shared/rust/string.regexp.interpolated/interpolation/delimiters ref rust/string.interpolated/interpolation/delimiters
add-highlighter shared/rust/string.regexp.interpolated/interpolation/rust ref rust

# Note: Avoid unterminated regular expression and floor division as regex.
#
# Examples:
#
# division ⇒ 1 / 2
# floor division ⇒ 1 // 2
#
add-highlighter shared/rust/division-as-region region ' //? ' '.\K' group
add-highlighter shared/rust/division-as-region/operator regex '//?' 0:operator

# Percent regex literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %r(foo|bar)
#
add-highlighter shared/rust/string.regexp.percent.parenthesis.interpolated region -recurse '\(' '%r\(' '\)[imx]*' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.regexp.percent.bracket.interpolated region -recurse '\[' '%r\[' '\][imx]*' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.regexp.percent.brace.interpolated region -recurse '\{' '%r\{' '\}[imx]*' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.regexp.percent.angle.interpolated region -recurse '<' '%r<' '>[imx]*' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.regexp.percent.pipe.interpolated region '%r\|' '\|[imx]*' ref rust/string.regexp.interpolated

# Command literal ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Reference
# https://rust-lang.org/reference/master/syntax_and_semantics/literals/command.html

# Example:
#
# `echo foo`
#
add-highlighter shared/rust/string.command region '`' '(?<!\\)(\\\\)*`' ref rust/string.regexp.interpolated

# Percent command literals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Example:
#
# %x(echo foo)
#
add-highlighter shared/rust/string.command.percent.parenthesis region -recurse '\(' '%x\(' '\)' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.command.percent.bracket region -recurse '\[' '%x\[' '\]' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.command.percent.brace region -recurse '\{' '%x\{' '\}' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.command.percent.angle region -recurse '<' '%x<' '>' ref rust/string.regexp.interpolated
add-highlighter shared/rust/string.command.percent.pipe region '%x\|' '\|' ref rust/string.regexp.interpolated

# What’s new ───────────────────────────────────────────────────────────────────

# Builds a ready for use `str-list` and `regex` with selections.
#
# Usage:
#
# Fetch a document, select keywords and call `rust-build-result keywords`.
#
define-command -hidden rust-build-result -params 1 %{
  # Initialization
  execute-keys -save-regs '' 'y'
  edit -scratch

  execute-keys '%<a-R>a<ret><esc>y%<a-R>%|sort -u<ret><a-s>_'
  echo -debug rust %arg{1} as str-list:
  echo -debug -quoting kakoune %val{selections}

  execute-keys '%|awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>_'
  execute-keys -save-regs '' '*'
  echo -debug rust %arg{1} as regex:
  echo -debug -quoting kakoune %val{main_reg_slash}

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}

define-command -hidden rust-build-result-with-static-words -params 1 %{
  rust-build-result %arg{1}
  set-option -add window static_words %val{selections}
}

define-command -hidden rust-check-news %{
  # Initialization
  edit -scratch
  set-option window static_words

  # Keywords ⇒ https://github.com/rust-lang/rust/blob/master/src/compiler/rust/syntax/lexer.cr
  execute-keys '%|curl -sSL https://github.com/rust-lang/rust/raw/master/src/compiler/rust/syntax/lexer.cr<ret>'
  execute-keys '%1<s>check_ident_or_keyword\(:(%opt{rust_word_pattern}<a-!>),\h+\w+\)<ret>Z%1<s>@token\.value\h+=\h+:(%opt{rust_word_pattern}<a-!>)<ret><a-z>a'
  rust-build-result-with-static-words keywords

  # Top Level Namespace
  # https://rust-lang.org/api/master/toplevel.html#method-summary
  # https://rust-lang.org/api/master/toplevel.html#macro-summary
  execute-keys '%|curl -sSL https://rust-lang.org/api/master/toplevel.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{rust_word_pattern}<a-!>)[^"]*-(method|macro)"<ret>'
  rust-build-result-with-static-words top-level-namespace

  # Object macros ⇒ https://rust-lang.org/api/master/Object.html#macro-summary
  execute-keys '%|curl -sSL https://rust-lang.org/api/master/Object.html<ret>'
  execute-keys '%1<s>class="entry-detail"\h+id="(%opt{rust_word_pattern}<a-!>)[^"]*-(macro)"<ret>'
  rust-build-result-with-static-words object-macros

  # Static words
  set-register dquote %opt{static_words}
  execute-keys '%<a-R>'
  rust-build-result static_words

  # Cleanup
  delete-buffer
  echo 'Open the *debug* buffer to see result.'
}
