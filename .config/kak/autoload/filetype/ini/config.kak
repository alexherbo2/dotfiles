# INI
# https://ini.org

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
