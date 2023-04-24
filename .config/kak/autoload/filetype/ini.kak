# INI
# https://ini.org

# kakoune-ini
# This Kakoune extension allows you to define a language configuration that controls the following declarative language features.
# Features
# - Comment toggling
# - Indentation rules
# Installation
# Alternatively, add comment.kak and indent.kak to your autoload directory.
# This [Kakoune] extension provides support for the [INI] programming language.

# [Kakoune]: https://kakoune.org
# [INI]: https://ini-lang.org

## Features

# - Syntax highlighting
# - Auto-indentation

# Configuration ────────────────────────────────────────────────────────────────

# Word pattern
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#word-pattern
declare-option -docstring 'INI word pattern' str ini_word_pattern '\w+[?!]?'

# Reference
#
# https://ini-lang.org/reference/master/syntax_and_semantics/control_expressions.html
#
# https://ini-lang.org/reference/master/syntax_and_semantics/if.html
#
# value = if some_condition
# elsif some_other_condition
# else
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/unless.html
#
# value = unless some_condition
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/case.html
#
# value = case expression
# when value
# end
#
# value = case expression
# in value
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/while.html
#
# while some_condition
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/until.html
#
# until some_condition
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/types_and_methods.html
# https://ini-lang.org/reference/master/syntax_and_semantics/visibility.html
# https://ini-lang.org/reference/master/syntax_and_semantics/virtual_and_abstract_types.html
#
# https://ini-lang.org/reference/master/syntax_and_semantics/classes_and_methods.html
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
# https://ini-lang.org/reference/master/syntax_and_semantics/modules.html
#
# module INI
# end
#
# private module INI
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/structs.html
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
# https://ini-lang.org/reference/master/syntax_and_semantics/enum.html
#
# enum Color
# end
#
# private enum Color
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/blocks_and_procs.html
#
# loop do
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/exception_handling.html
#
# begin
# rescue exception
# ensure
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/macros/
#
# macro version
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/annotations/
#
# annotation Link
# end
#
# https://ini-lang.org/reference/master/syntax_and_semantics/c_bindings/
# https://ini-lang.org/reference/master/syntax_and_semantics/c_bindings/lib.html
#
# lib C
# end
#
# private lib C
# end

# Detection ────────────────────────────────────────────────────────────────────

# Sets INI filetype when opening `.ini` files.
remove-hooks global ini-detection
hook -group ini-detection global BufCreate '.+\.ini' %{
  set-option buffer filetype ini
}

# Enables syntax highlighting for INI filetype.
remove-hooks global ini-highlight
hook -group ini-highlight global WinSetOption filetype=ini %{
  add-highlighter window/ini ref ini
  hook -always -once window WinSetOption 'filetype=.*' %{
    remove-highlighter window/ini
  }
}

# Configures word selection and completion for INI filetype.
# `static_words` option is generated with `ini-check-news`.
remove-hooks global ini-config
hook -group ini-config global WinSetOption filetype=ini %{
  set-option window increase_indent_pattern '^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option window decrease_indent_pattern '^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option window ignore_indent_pattern '^\h*#'
  set-option window line_comment_token ';'
  set-option buffer extra_word_chars '_' '?' '!'
  set-option window static_words 'abort' 'abstract' 'alias' 'annotation' 'as' 'as?' 'asm' 'at_exit' 'begin' 'break' 'caller' 'case' 'class' 'class_getter' 'class_getter!' 'class_getter?' 'class_property' 'class_property!' 'class_property?' 'class_setter' 'debugger' 'def' 'def_clone' 'def_equals' 'def_equals_and_hash' 'def_hash' 'delegate' 'do' 'else' 'elsif' 'end' 'ensure' 'enum' 'exit' 'extend' 'false' 'for' 'forward_missing_to' 'fun' 'gets' 'getter' 'getter!' 'getter?' 'if' 'in' 'include' 'instance_sizeof' 'is_a?' 'lib' 'loop' 'macro' 'main' 'module' 'next' 'nil' 'nil?' 'of' 'offsetof' 'out' 'p' 'p!' 'pointerof' 'pp' 'pp!' 'print' 'printf' 'private' 'property' 'property!' 'property?' 'protected' 'puts' 'raise' 'raise_without_backtrace' 'rand' 'read_line' 'record' 'require' 'rescue' 'responds_to?' 'return' 'select' 'self' 'setter' 'sizeof' 'sleep' 'spawn' 'sprintf' 'struct' 'super' 'system' 'then' 'timeout_select_action' 'true' 'type' 'typeof' 'uninitialized' 'union' 'unless' 'until' 'verbatim' 'when' 'while' 'with' 'yield'
  hook -always -once window WinSetOption 'filetype=.*' %{
    unset-option window line_comment_token
    unset-option buffer extra_word_chars
    unset-option window static_words
  }
}

# Highlighters ─────────────────────────────────────────────────────────────────

# Creates the base regions
add-highlighter shared/ini regions
add-highlighter shared/ini/code default-region group
add-highlighter shared/ini/code/key regex '(?S)^\h*(\w+)\h*=\h*(.+)\h*$' 1:variable 2:value
add-highlighter shared/ini/code/section regex '(?S)^\h*\[.*\]\h*$' 0:title
add-highlighter shared/ini/comment region '[;#]' '$' group
add-highlighter shared/ini/comment/fill fill comment
