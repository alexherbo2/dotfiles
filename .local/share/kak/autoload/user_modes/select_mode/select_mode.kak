# name: kakoune_select_mode
# version: 0.1.0
# description: This script provides the functionality to subselect text objects.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
declare-user-mode select

define-command -hidden enter_select_mode %{
  enter-user-mode select
}

map -docstring 'regex matches' global select / ':select_regex_matches<ret>'

map -docstring 'inner parenthesis blocks' global select b ':select_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select ( ':select_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select ) ':select_parenthesis_blocks<ret>'

map -docstring 'inner brace blocks' global select B ':select_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select { ':select_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select } ':select_brace_blocks<ret>'

map -docstring 'inner bracket blocks' global select r ':select_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select [ ':select_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select ] ':select_bracket_blocks<ret>'

map -docstring 'inner angle blocks' global select a ':select_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select <lt> ':select_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select <gt> ':select_angle_blocks<ret>'

map -docstring 'inner double quote strings' global select Q ':select_double_quote_strings<ret>'
map -docstring 'inner double quote strings' global select '"' ':select_double_quote_strings<ret>'

map -docstring 'inner single quote strings' global select q ':select_single_quote_strings<ret>'
map -docstring 'inner single quote strings' global select "'" ':select_single_quote_strings<ret>'

map -docstring 'inner grave quote strings' global select g ':select_grave_quote_strings<ret>'
map -docstring 'inner grave quote strings' global select ` ':select_grave_quote_strings<ret>'

map -docstring 'words' global select w ':select_words<ret>'
map -docstring 'long words' global select <a-w> ':select_long_words<ret>'
map -docstring 'sentences' global select s ':select_sentences<ret>'
map -docstring 'paragraphs' global select p ':select_paragraphs<ret>'
map -docstring 'whitespaces' global select <space> ':select_whitespaces<ret>'
map -docstring 'indent' global select i ':select_indent<ret>'
map -docstring 'numbers' global select n ':select_numbers<ret>'
map -docstring 'arguments' global select u ':select_arguments<ret>'
