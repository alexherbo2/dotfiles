map global insert <tab> '<a-;>:increase_indent<ret>'
map global insert <s-tab> '<a-;>:decrease_indent<ret>'
map global insert <c-u> '<a-;>:erase_characters_before_cursor_to_line_begin<ret>'
map global insert <c-w> '<a-;>:erase_word_before_cursor<ret>'
map -docstring 'insert clipboard contents' global insert <c-y> '<c-r>"'
map -docstring 'move cursors to the start of the line' global insert <c-a> '<home>'
map -docstring 'move cursors to the end of the line' global insert <c-e> '<end>'
map -docstring 'move cursors to the next character' global insert <c-f> '<right>'
map -docstring 'move cursors to the previous character' global insert <c-b> '<left>'

hook global InsertCompletionShow '.*' %{
  map window insert <tab> <c-n>
  map window insert <s-tab> <c-p>
  hook -once window InsertCompletionHide '.*' %{
    unmap window insert <tab>
    unmap window insert <s-tab>
  }
}
