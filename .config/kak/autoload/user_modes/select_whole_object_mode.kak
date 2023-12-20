# name: kakoune_select_whole_object_mode
# version: 0.1.0
# description: This script provides the functionality to select “whole objects”.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
declare-user-mode select_whole_object

define-command -hidden enter_select_whole_object_mode %{
  enter-user-mode select_whole_object
}

define-command -hidden select_whole_regex_matches %{
  execute-keys 's'
}

define-command -hidden select_whole_parenthesis_blocks %{
  execute-keys 's\(<ret><a-a>b'
}

define-command -hidden select_whole_brace_blocks %{
  execute-keys 's\{<ret><a-a>B' # }
}

define-command -hidden select_whole_bracket_blocks %{
  execute-keys 's\[<ret><a-a>r'
}

define-command -hidden select_whole_angle_blocks %{
  execute-keys 's<lt><ret><a-a>a'
}

define-command -hidden select_whole_double_quote_strings %{
  execute-keys 's"[^"]*"<ret><a-;><a-a>Q'
}

define-command -hidden select_whole_single_quote_strings %{
  execute-keys "s'[^']*'<ret><a-;><a-a>q"
}

define-command -hidden select_whole_grave_quote_strings %{
  execute-keys 's`[^`]*`<ret><a-;><a-a>g'
}

define-command -hidden select_whole_words %{
  execute-keys 's\w+<ret><a-a>w'
}

define-command -hidden select_whole_long_words %{
  execute-keys 's\w+<ret><a-a><a-w>'
}

define-command -hidden select_whole_sentences %{
  execute-keys 's[^\n]+<ret><a-a>s'
}

define-command -hidden select_whole_paragraphs %{
  execute-keys 's[^\n]+<ret><a-a>p'
}

define-command -hidden select_whole_whitespaces %{
  execute-keys 's\h+<ret><a-a><space>'
}

define-command -hidden select_whole_indent %{
  execute-keys 's^\h+<ret><a-a><space>'
}

define-command -hidden select_whole_numbers %{
  execute-keys 's\d+<ret><a-a>n'
}

define-command -hidden select_whole_arguments %{
  execute-keys 's\(<ret><a-i>bs\w+<ret><a-a>u'
}

map -docstring 'regex matches' global select_whole_object / ':select_whole_regex_matches<ret>'

map -docstring 'whole parenthesis blocks' global select_whole_object b ':select_whole_parenthesis_blocks<ret>'
map -docstring 'whole parenthesis blocks' global select_whole_object ( ':select_whole_parenthesis_blocks<ret>'
map -docstring 'whole parenthesis blocks' global select_whole_object ) ':select_whole_parenthesis_blocks<ret>'

map -docstring 'whole brace blocks' global select_whole_object B ':select_whole_brace_blocks<ret>'
map -docstring 'whole brace blocks' global select_whole_object { ':select_whole_brace_blocks<ret>'
map -docstring 'whole brace blocks' global select_whole_object } ':select_whole_brace_blocks<ret>'

map -docstring 'whole bracket blocks' global select_whole_object r ':select_whole_bracket_blocks<ret>'
map -docstring 'whole bracket blocks' global select_whole_object [ ':select_whole_bracket_blocks<ret>'
map -docstring 'whole bracket blocks' global select_whole_object ] ':select_whole_bracket_blocks<ret>'

map -docstring 'whole angle blocks' global select_whole_object a ':select_whole_angle_blocks<ret>'
map -docstring 'whole angle blocks' global select_whole_object <lt> ':select_whole_angle_blocks<ret>'
map -docstring 'whole angle blocks' global select_whole_object <gt> ':select_whole_angle_blocks<ret>'

map -docstring 'whole double quote strings' global select_whole_object Q ':select_whole_double_quote_strings<ret>'
map -docstring 'whole double quote strings' global select_whole_object '"' ':select_whole_double_quote_strings<ret>'

map -docstring 'whole single quote strings' global select_whole_object q ':select_whole_single_quote_strings<ret>'
map -docstring 'whole single quote strings' global select_whole_object "'" ':select_whole_single_quote_strings<ret>'

map -docstring 'whole grave quote strings' global select_whole_object g ':select_whole_grave_quote_strings<ret>'
map -docstring 'whole grave quote strings' global select_whole_object ` ':select_whole_grave_quote_strings<ret>'

map -docstring 'words' global select_whole_object w ':select_whole_words<ret>'
map -docstring 'long words' global select_whole_object <a-w> ':select_whole_long_words<ret>'
map -docstring 'sentences' global select_whole_object s ':select_whole_sentences<ret>'
map -docstring 'paragraphs' global select_whole_object p ':select_whole_paragraphs<ret>'
map -docstring 'whitespaces' global select_whole_object <space> ':select_whole_whitespaces<ret>'
map -docstring 'indent' global select_whole_object i ':select_whole_indent<ret>'
map -docstring 'numbers' global select_whole_object n ':select_whole_numbers<ret>'
map -docstring 'arguments' global select_whole_object u ':select_whole_arguments<ret>'
