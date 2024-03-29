define-command erase_characters_before_cursor_to_line_begin %{
  evaluate-commands -draft %{
    execute-keys '<a-h>'
    evaluate-commands -draft -itersel -verbatim -- try %{
      execute-keys '<a-k>^.\z<ret>'
    } catch %{
      execute-keys '<a-k>^\h+.\z<ret><a-:>Hd'
    } catch %{
      execute-keys '<a-k>^\h+\H<ret>WL<a-:>Hd'
    } catch %{
      execute-keys '<a-:>Hd'
    } catch %{}
  }
  execute-keys '<a-;><a-:><a-;><a-;>'
}

map global insert <c-u> '<a-;>:erase_characters_before_cursor_to_line_begin<ret>'

define-command erase_word_before_cursor %{
  evaluate-commands -draft %{
    execute-keys ';<a-_>'
    evaluate-commands -draft -itersel -verbatim -- try %{
      execute-keys -draft '<a-k>^.\z<ret>'
    } catch %{
      execute-keys -draft 'h<a-k>^.\z<ret>d'
    } catch %{
      execute-keys -draft 'h<a-k>\b\w|\B[^\w\h]<ret>d'
    } catch %{
      execute-keys -draft 'hBd'
    } catch %{}
  }
}

map global insert <c-w> '<a-;>:erase_word_before_cursor<ret>'

map -docstring 'insert clipboard contents' global insert <c-y> '<c-r>"'
map -docstring 'move cursors to the start of the line' global insert <c-a> '<home>'
map -docstring 'move cursors to the end of the line' global insert <c-e> '<end>'
map -docstring 'move cursors to the next character' global insert <c-f> '<right>'
map -docstring 'move cursors to the previous character' global insert <c-b> '<left>'
