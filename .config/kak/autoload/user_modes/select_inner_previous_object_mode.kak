declare-user-mode select_inner_previous_object

define-command -hidden enter_select_inner_previous_object_mode %{
  enter-user-mode select_inner_previous_object
}

define-command -hidden select_inner_previous_parenthesis_blocks %{
  execute-keys '<a-f>(<a-i>b<a-;>'
}

define-command -hidden select_inner_previous_brace_blocks %{
  execute-keys '<a-f>{<a-i>B<a-;>' # }
}

define-command -hidden select_inner_previous_bracket_blocks %{
  execute-keys '<a-f>[<a-i>r<a-;>'
}

define-command -hidden select_inner_previous_angle_blocks %{
  execute-keys '<a-f><lt><a-i>a<a-;>'
}

define-command -hidden select_inner_previous_double_quote_strings %{
  execute-keys '<a-f>"h<a-i>Q<a-;>'
}

define-command -hidden select_inner_previous_single_quote_strings %{
  execute-keys "<a-f>'h<a-i>q<a-;>"
}

define-command -hidden select_inner_previous_grave_quote_strings %{
  execute-keys '<a-f>`h<a-i>g<a-;>'
}

define-command -hidden select_inner_previous_object_words %{
  execute-keys 'l<a-/>\W\w<ret><a-i>w<a-;>'
}

define-command -hidden select_inner_previous_object_long_words %{
  execute-keys 'l<a-/>\W\w<ret><a-i><a-w><a-;>'
}

define-command -hidden select_inner_previous_object_sentences %{
  execute-keys '<a-i>s<a-;>[s<a-i>s<a-;>'
}

define-command -hidden select_inner_previous_object_paragraphs %{
  execute-keys '<a-i>p<a-;>[p'
}

define-command -hidden select_inner_previous_object_whitespaces %{
  execute-keys '<a-/>\s+<ret><a-i><space><a-;>'
}

define-command -hidden select_inner_previous_object_indent %{
  execute-keys 'k<a-i>i<a-;>'
}

define-command -hidden select_inner_previous_object_numbers %{
  execute-keys '<a-/>\d+<ret><a-i>n<a-;>'
}

define-command -hidden select_inner_previous_object_arguments %{
  execute-keys '<a-/>\(\K|,|.(?=\))<ret><a-i>u<a-;>'
}

map -docstring 'parenthesis blocks' global select_inner_previous_object b ':select_inner_previous_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_inner_previous_object ( ':select_inner_previous_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_inner_previous_object ) ':select_inner_previous_parenthesis_blocks<ret>'

map -docstring 'brace blocks' global select_inner_previous_object B ':select_inner_previous_brace_blocks<ret>'
map -docstring 'brace blocks' global select_inner_previous_object { ':select_inner_previous_brace_blocks<ret>'
map -docstring 'brace blocks' global select_inner_previous_object } ':select_inner_previous_brace_blocks<ret>'

map -docstring 'bracket blocks' global select_inner_previous_object r ':select_inner_previous_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_inner_previous_object [ ':select_inner_previous_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_inner_previous_object ] ':select_inner_previous_bracket_blocks<ret>'

map -docstring 'angle blocks' global select_inner_previous_object a ':select_inner_previous_angle_blocks<ret>'
map -docstring 'angle blocks' global select_inner_previous_object <lt> ':select_inner_previous_angle_blocks<ret>'
map -docstring 'angle blocks' global select_inner_previous_object <gt> ':select_inner_previous_angle_blocks<ret>'

map -docstring 'double quote strings' global select_inner_previous_object Q ':select_inner_previous_double_quote_strings<ret>'
map -docstring 'double quote strings' global select_inner_previous_object '"' ':select_inner_previous_double_quote_strings<ret>'

map -docstring 'single quote strings' global select_inner_previous_object q ':select_inner_previous_single_quote_strings<ret>'
map -docstring 'single quote strings' global select_inner_previous_object "'" ':select_inner_previous_single_quote_strings<ret>'

map -docstring 'grave quote strings' global select_inner_previous_object g ':select_inner_previous_grave_quote_strings<ret>'
map -docstring 'grave quote strings' global select_inner_previous_object ` ':select_inner_previous_grave_quote_strings<ret>'

map -docstring 'words' global select_inner_previous_object w ':select_inner_previous_object_words<ret>'
map -docstring 'long words' global select_inner_previous_object W ':select_inner_previous_object_long_words<ret>'
map -docstring 'sentences' global select_inner_previous_object s ':select_inner_previous_object_sentences<ret>'
map -docstring 'paragraphs' global select_inner_previous_object p ':select_inner_previous_object_paragraphs<ret>'
map -docstring 'whitespaces' global select_inner_previous_object <space> ':select_inner_previous_object_whitespaces<ret>'
map -docstring 'indent' global select_inner_previous_object i ':select_inner_previous_object_indent<ret>'
map -docstring 'numbers' global select_inner_previous_object n ':select_inner_previous_object_numbers<ret>'
map -docstring 'arguments' global select_inner_previous_object u ':select_inner_previous_object_arguments<ret>'
