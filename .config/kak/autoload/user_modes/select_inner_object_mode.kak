# name: kakoune_select_inner_object_mode
# version: 0.1.0
# description: This script provides the functionality to select “inner objects”.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
declare-user-mode select_inner_object

define-command -hidden enter_select_inner_object_mode %{
  enter-user-mode select_inner_object
}

define-command -hidden select_inner_regex_matches %{
  execute-keys 's'
}

define-command -hidden select_inner_parenthesis_blocks %{
  execute-keys 's\(<ret><a-i>b'
}

define-command -hidden select_inner_brace_blocks %{
  execute-keys 's\{<ret><a-i>B' # }
}

define-command -hidden select_inner_bracket_blocks %{
  execute-keys 's\[<ret><a-i>r'
}

define-command -hidden select_inner_angle_blocks %{
  execute-keys 's<lt><ret><a-i>a'
}

define-command -hidden select_inner_double_quote_strings %{
  execute-keys 's"[^"]*"<ret><a-;><a-i>Q'
}

define-command -hidden select_inner_single_quote_strings %{
  execute-keys "s'[^']*'<ret><a-;><a-i>q"
}

define-command -hidden select_inner_grave_quote_strings %{
  execute-keys 's`[^`]*`<ret><a-;><a-i>g'
}

define-command -hidden select_inner_words %{
  execute-keys 's\w+<ret><a-i>w'
}

define-command -hidden select_inner_long_words %{
  execute-keys 's\w+<ret><a-i><a-w>'
}

define-command -hidden select_inner_sentences %{
  execute-keys 's[^\n]+<ret><a-i>s'
}

define-command -hidden select_inner_paragraphs %{
  execute-keys 's[^\n]+<ret><a-i>p'
}

define-command -hidden select_inner_whitespaces %{
  execute-keys 's\h+<ret><a-i><space>'
}

define-command -hidden select_inner_indent %{
  execute-keys 's^\h+<ret><a-i><space>'
}

define-command -hidden select_inner_numbers %{
  execute-keys 's\d+<ret><a-i>n'
}

define-command -hidden select_inner_arguments %{
  execute-keys 's\(<ret><a-i>bs\w+<ret><a-i>u'
}

map -docstring 'regex matches' global select_inner_object / ':select_inner_regex_matches<ret>'

map -docstring 'inner parenthesis blocks' global select_inner_object b ':select_inner_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select_inner_object ( ':select_inner_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select_inner_object ) ':select_inner_parenthesis_blocks<ret>'

map -docstring 'inner brace blocks' global select_inner_object B ':select_inner_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select_inner_object { ':select_inner_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select_inner_object } ':select_inner_brace_blocks<ret>'

map -docstring 'inner bracket blocks' global select_inner_object r ':select_inner_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select_inner_object [ ':select_inner_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select_inner_object ] ':select_inner_bracket_blocks<ret>'

map -docstring 'inner angle blocks' global select_inner_object a ':select_inner_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select_inner_object <lt> ':select_inner_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select_inner_object <gt> ':select_inner_angle_blocks<ret>'

map -docstring 'inner double quote strings' global select_inner_object Q ':select_inner_double_quote_strings<ret>'
map -docstring 'inner double quote strings' global select_inner_object '"' ':select_inner_double_quote_strings<ret>'

map -docstring 'inner single quote strings' global select_inner_object q ':select_inner_single_quote_strings<ret>'
map -docstring 'inner single quote strings' global select_inner_object "'" ':select_inner_single_quote_strings<ret>'

map -docstring 'inner grave quote strings' global select_inner_object g ':select_inner_grave_quote_strings<ret>'
map -docstring 'inner grave quote strings' global select_inner_object ` ':select_inner_grave_quote_strings<ret>'

map -docstring 'words' global select_inner_object w ':select_inner_words<ret>'
map -docstring 'long words' global select_inner_object <a-w> ':select_inner_long_words<ret>'
map -docstring 'sentences' global select_inner_object s ':select_inner_sentences<ret>'
map -docstring 'paragraphs' global select_inner_object p ':select_inner_paragraphs<ret>'
map -docstring 'whitespaces' global select_inner_object <space> ':select_inner_whitespaces<ret>'
map -docstring 'indent' global select_inner_object i ':select_inner_indent<ret>'
map -docstring 'numbers' global select_inner_object n ':select_inner_numbers<ret>'
map -docstring 'arguments' global select_inner_object u ':select_inner_arguments<ret>'
