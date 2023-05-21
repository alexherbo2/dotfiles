declare-user-mode select_previous_object

define-command -hidden enter_select_previous_object_mode %{
  enter-user-mode select_previous_object
}

define-command -hidden select_previous_parenthesis_blocks %{
  execute-keys '<a-f>(h<a-a>b<a-;>'
}

define-command -hidden select_previous_brace_blocks %{
  execute-keys '<a-f>{h<a-a>B<a-;>' # }
}

define-command -hidden select_previous_bracket_blocks %{
  execute-keys '<a-f>[h<a-a>r<a-;>'
}

define-command -hidden select_previous_angle_blocks %{
  execute-keys 's<lt>h<a-a>a<a-;>'
}

define-command -hidden select_previous_double_quote_strings %{
  execute-keys '<a-f>"h<a-a>Q<a-;>'
}

define-command -hidden select_previous_single_quote_strings %{
  execute-keys "<a-f>'h<a-a>q<a-;>"
}

define-command -hidden select_previous_grave_quote_strings %{
  execute-keys '<a-f>`h<a-a>g<a-;>'
}

define-command -hidden select_previous_object_words %{
  execute-keys 'l<a-/>\W\w<ret><a-a>w<a-;>'
}

define-command -hidden select_previous_object_long_words %{
  execute-keys 'l<a-/>\W\w<ret><a-a><a-w><a-;>'
}

define-command -hidden select_previous_object_sentences %{
  execute-keys 'h[sh<a-a>s<a-;>'
}

define-command -hidden select_previous_object_paragraphs %{
  execute-keys 'h[ph<a-a>p<a-;>'
}

define-command -hidden select_previous_object_whitespaces %{
  execute-keys '<a-/>\s+<ret><a-a><space><a-;>'
}

define-command -hidden select_previous_object_indent %{
  execute-keys 'k<a-a>i<a-;>'
}

define-command -hidden select_previous_object_numbers %{
  execute-keys '<a-/>\d+<ret><a-a>n<a-;>'
}

define-command -hidden select_previous_object_arguments %{
  execute-keys '<a-/>\(\K|,|.(?=\))<ret><a-a>u<a-;>'
}

map -docstring 'parenthesis blocks' global select_previous_object b ':select_next_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_previous_object ( ':select_next_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_previous_object ) ':select_previous_parenthesis_blocks<ret>'

map -docstring 'brace blocks' global select_previous_object B ':select_next_brace_blocks<ret>'
map -docstring 'brace blocks' global select_previous_object { ':select_next_brace_blocks<ret>'
map -docstring 'brace blocks' global select_previous_object } ':select_previous_brace_blocks<ret>'

map -docstring 'bracket blocks' global select_previous_object r ':select_next_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_previous_object [ ':select_next_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_previous_object ] ':select_previous_bracket_blocks<ret>'

map -docstring 'angle blocks' global select_previous_object a ':select_next_angle_blocks<ret>'
map -docstring 'angle blocks' global select_previous_object <lt> ':select_next_angle_blocks<ret>'
map -docstring 'angle blocks' global select_previous_object <gt> ':select_previous_angle_blocks<ret>'

map -docstring 'double quote strings' global select_previous_object Q ':select_next_double_quote_strings<ret>'
map -docstring 'double quote strings' global select_previous_object '"' ':select_next_double_quote_strings<ret>'

map -docstring 'single quote strings' global select_previous_object q ':select_next_single_quote_strings<ret>'
map -docstring 'single quote strings' global select_previous_object "'" ':select_next_single_quote_strings<ret>'

map -docstring 'grave quote strings' global select_previous_object g ':select_next_grave_quote_strings<ret>'
map -docstring 'grave quote strings' global select_previous_object ` ':select_next_grave_quote_strings<ret>'

map -docstring 'words' global select_previous_object w ':select_previous_object_words<ret>'
map -docstring 'long words' global select_previous_object W ':select_previous_object_long_words<ret>'
map -docstring 'sentences' global select_previous_object s ':select_previous_object_sentences<ret>'
map -docstring 'paragraphs' global select_previous_object p ':select_previous_object_paragraphs<ret>'
map -docstring 'whitespaces' global select_previous_object <space> ':select_previous_object_whitespaces<ret>'
map -docstring 'indent' global select_previous_object i ':select_previous_object_indent<ret>'
map -docstring 'numbers' global select_previous_object n ':select_previous_object_numbers<ret>'
map -docstring 'arguments' global select_previous_object u ':select_previous_object_arguments<ret>'
