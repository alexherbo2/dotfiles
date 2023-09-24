define-command erase_characters_before_cursor_to_line_begin %{
  try %{
    execute-keys -draft '<a-h><a-K>^.\z<ret><a-:>Hd'
    execute-keys '<a-;><a-:><a-;><a-;>'
  }
}

map global insert <c-u> '<a-;>:erase_characters_before_cursor_to_line_begin<ret>'

define-command erase_word_before_cursor %{
  evaluate-commands -draft -itersel -verbatim -- try %{
    execute-keys ';<a-K>^.\z<ret>h'
    try %{
      execute-keys -draft '<a-k>^.\z<ret>d'
    } catch %{
      execute-keys -draft 'Bd'
    }
  }
}

map global insert <c-w> '<a-;>:erase_word_before_cursor<ret>'

map global insert <c-y> '<c-r>"'
