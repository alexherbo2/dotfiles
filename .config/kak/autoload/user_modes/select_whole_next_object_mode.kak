declare-user-mode select_whole_next_object

define-command -hidden enter_select_whole_next_object_mode %{
  enter-user-mode select_whole_next_object
}

define-command -hidden select_whole_next_parenthesis_blocks %{
  execute-keys 'f(<a-a>b'
}

define-command -hidden select_whole_next_brace_blocks %{
  execute-keys 'f{<a-a>B' # }
}

define-command -hidden select_whole_next_bracket_blocks %{
  execute-keys 'f[<a-a>r'
}

define-command -hidden select_whole_next_angle_blocks %{
  execute-keys 'f<lt><a-a>a'
}

define-command -hidden select_whole_next_double_quote_strings %{
  execute-keys 'f"<a-a>Q'
}

define-command -hidden select_whole_next_single_quote_strings %{
  execute-keys "f'<a-a>q"
}

define-command -hidden select_whole_next_grave_quote_strings %{
  execute-keys 'f`<a-a>g'
}

define-command -hidden select_whole_next_object_words %{
  execute-keys 'h/\W\w<ret><a-a>w'
}

define-command -hidden select_whole_next_object_long_words %{
  execute-keys 'h/\W\w<ret><a-a><a-w>'
}

define-command -hidden select_whole_next_object_sentences %{
  execute-keys '<a-i>sl<a-a>s'
}

define-command -hidden select_whole_next_object_paragraphs %{
  execute-keys '<a-i>pl<a-a>p'
}

define-command -hidden select_whole_next_object_whitespaces %{
  execute-keys '/\s+<ret><a-a><space>'
}

define-command -hidden select_whole_next_object_indent %{
  execute-keys 'j<a-a>i'
}

define-command -hidden select_whole_next_object_numbers %{
  execute-keys '/\d+<ret><a-a>n'
}

define-command -hidden select_whole_next_object_arguments %{
  execute-keys '/\(\K|,|.(?=\))<ret><a-a>u'
}

map -docstring 'parenthesis blocks' global select_whole_next_object b ':select_whole_next_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_whole_next_object ( ':select_whole_next_parenthesis_blocks<ret>'
map -docstring 'parenthesis blocks' global select_whole_next_object ) ':select_whole_next_parenthesis_blocks<ret>'

map -docstring 'brace blocks' global select_whole_next_object B ':select_whole_next_brace_blocks<ret>'
map -docstring 'brace blocks' global select_whole_next_object { ':select_whole_next_brace_blocks<ret>'
map -docstring 'brace blocks' global select_whole_next_object } ':select_whole_next_brace_blocks<ret>'

map -docstring 'bracket blocks' global select_whole_next_object r ':select_whole_next_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_whole_next_object [ ':select_whole_next_bracket_blocks<ret>'
map -docstring 'bracket blocks' global select_whole_next_object ] ':select_whole_next_bracket_blocks<ret>'

map -docstring 'angle blocks' global select_whole_next_object a ':select_whole_next_angle_blocks<ret>'
map -docstring 'angle blocks' global select_whole_next_object <lt> ':select_whole_next_angle_blocks<ret>'
map -docstring 'angle blocks' global select_whole_next_object <gt> ':select_whole_next_angle_blocks<ret>'

map -docstring 'double quote strings' global select_whole_next_object Q ':select_whole_next_double_quote_strings<ret>'
map -docstring 'double quote strings' global select_whole_next_object '"' ':select_whole_next_double_quote_strings<ret>'

map -docstring 'single quote strings' global select_whole_next_object q ':select_whole_next_single_quote_strings<ret>'
map -docstring 'single quote strings' global select_whole_next_object "'" ':select_whole_next_single_quote_strings<ret>'

map -docstring 'grave quote strings' global select_whole_next_object g ':select_whole_next_grave_quote_strings<ret>'
map -docstring 'grave quote strings' global select_whole_next_object ` ':select_whole_next_grave_quote_strings<ret>'

map -docstring 'words' global select_whole_next_object w ':select_whole_next_object_words<ret>'
map -docstring 'long words' global select_whole_next_object W ':select_whole_next_object_long_words<ret>'
map -docstring 'sentences' global select_whole_next_object s ':select_whole_next_object_sentences<ret>'
map -docstring 'paragraphs' global select_whole_next_object p ':select_whole_next_object_paragraphs<ret>'
map -docstring 'whitespaces' global select_whole_next_object <space> ':select_whole_next_object_whitespaces<ret>'
map -docstring 'indent' global select_whole_next_object i ':select_whole_next_object_indent<ret>'
map -docstring 'numbers' global select_whole_next_object n ':select_whole_next_object_numbers<ret>'
map -docstring 'arguments' global select_whole_next_object u ':select_whole_next_object_arguments<ret>'
