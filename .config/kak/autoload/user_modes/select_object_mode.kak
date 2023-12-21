# name: kakoune_select_object_mode
# version: 0.1.0
# description: This script provides the functionality to subselect text objects.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
declare-user-mode select_object

define-command -hidden enter_select_object_mode %{
  enter-user-mode select_object
}

define-command -hidden select_regex_matches %{
  execute-keys 's'
}

define-command -hidden select_parenthesis_blocks %{
  execute-keys 's\(<ret><a-a>b'
}

define-command -hidden select_brace_blocks %{
  execute-keys 's\{<ret><a-a>B' # }
}

define-command -hidden select_bracket_blocks %{
  execute-keys 's\[<ret><a-a>r'
}

define-command -hidden select_angle_blocks %{
  execute-keys 's<lt><ret><a-a>a'
}

define-command -hidden select_double_quote_strings %{
  execute-keys 's"[^"]*"<ret>'
}

define-command -hidden select_single_quote_strings %{
  execute-keys "s'[^']*'<ret>"
}

define-command -hidden select_grave_quote_strings %{
  execute-keys 's`[^`]*`<ret>'
}

define-command -hidden select_words %{
  execute-keys 's\w+<ret><a-i>w'
}

define-command -hidden select_long_words %{
  execute-keys 's\w+<ret><a-i><a-w>'
}

define-command -hidden select_sentences %{
  execute-keys 's.<ret><a-i>s'
}

define-command -hidden select_paragraphs %{
  execute-keys 's.<ret><a-i>p'
}

define-command -hidden select_whitespaces %{
  execute-keys 's\s+<ret>'
}

define-command -hidden select_indent %{
  execute-keys 's^\h+<ret><a-i>i'
}

define-command -hidden select_numbers %{
  execute-keys 's\d+<ret><a-a>n'
}

define-command -hidden select_arguments %{
  execute-keys 's[({[<lt>]<ret>m<a-k>\A.{3,}\z<ret>H<a-;>Ls.<ret><a-i>u' # }
}

map -docstring 'regex matches' global select_object / ':select_regex_matches<ret>'

map -docstring 'inner parenthesis blocks' global select_object b ':select_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select_object ( ':select_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select_object ) ':select_parenthesis_blocks<ret>'

map -docstring 'inner brace blocks' global select_object B ':select_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select_object { ':select_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select_object } ':select_brace_blocks<ret>'

map -docstring 'inner bracket blocks' global select_object r ':select_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select_object [ ':select_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select_object ] ':select_bracket_blocks<ret>'

map -docstring 'inner angle blocks' global select_object a ':select_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select_object <lt> ':select_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select_object <gt> ':select_angle_blocks<ret>'

map -docstring 'inner double quote strings' global select_object Q ':select_double_quote_strings<ret>'
map -docstring 'inner double quote strings' global select_object '"' ':select_double_quote_strings<ret>'

map -docstring 'inner single quote strings' global select_object q ':select_single_quote_strings<ret>'
map -docstring 'inner single quote strings' global select_object "'" ':select_single_quote_strings<ret>'

map -docstring 'inner grave quote strings' global select_object g ':select_grave_quote_strings<ret>'
map -docstring 'inner grave quote strings' global select_object ` ':select_grave_quote_strings<ret>'

map -docstring 'words' global select_object w ':select_words<ret>'
map -docstring 'long words' global select_object <a-w> ':select_long_words<ret>'
map -docstring 'sentences' global select_object s ':select_sentences<ret>'
map -docstring 'paragraphs' global select_object p ':select_paragraphs<ret>'
map -docstring 'whitespaces' global select_object <space> ':select_whitespaces<ret>'
map -docstring 'indent' global select_object i ':select_indent<ret>'
map -docstring 'numbers' global select_object n ':select_numbers<ret>'
map -docstring 'arguments' global select_object u ':select_arguments<ret>'
