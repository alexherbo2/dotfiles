declare-user-mode select

define-command -hidden enter_select_mode %{
  enter-user-mode select
}

define-command -hidden select_regex_matches %{
  execute-keys '/'
}

define-command -hidden select_inner_parenthesis_blocks %{
  execute-keys 's\(<ret><a-i>b'
}

define-command -hidden select_whole_parenthesis_blocks %{
  execute-keys 's\(<ret><a-a>b'
}

define-command -hidden select_inner_brace_blocks %{
  execute-keys 's\{<ret><a-i>B' # }
}

define-command -hidden select_whole_brace_blocks %{
  execute-keys 's\{<ret><a-a>B' # }
}

define-command -hidden select_inner_bracket_blocks %{
  execute-keys 's\[<ret><a-i>r'
}

define-command -hidden select_whole_bracket_blocks %{
  execute-keys 's\[<ret><a-a>r'
}

define-command -hidden select_inner_angle_blocks %{
  execute-keys 's<lt><ret><a-i>a'
}

define-command -hidden select_whole_angle_blocks %{
  execute-keys 's<lt><ret><a-a>a'
}

define-command -hidden select_inner_double_quote_strings %{
  execute-keys 's"[^"]*"<ret><a-;><a-i>Q'
}

define-command -hidden select_whole_double_quote_strings %{
  execute-keys 's"[^"]*"<ret><a-;><a-a>Q'
}

define-command -hidden select_inner_single_quote_strings %{
  execute-keys "s'[^']*'<ret><a-;><a-i>q"
}

define-command -hidden select_whole_single_quote_strings %{
  execute-keys "s'[^']*'<ret><a-;><a-a>q"
}

define-command -hidden select_inner_grave_quote_strings %{
  execute-keys 's`[^`]*`<ret><a-;><a-i>g'
}

define-command -hidden select_whole_grave_quote_strings %{
  execute-keys 's`[^`]*`<ret><a-;><a-a>g'
}

define-command -hidden select_words %{
  execute-keys 's\w+<ret><a-i>w'
}

define-command -hidden select_long_words %{
  execute-keys 's\w+<ret><a-i><a-w>'
}

define-command -hidden select_sentences %{
  execute-keys 's[^\n]+<ret><a-i>s'
}

define-command -hidden select_paragraphs %{
  execute-keys 's[^\n]+<ret><a-i>p'
}

define-command -hidden select_whitespaces %{
  execute-keys 's\h+<ret><a-i><space>'
}

define-command -hidden select_indent %{
  execute-keys 's^\h+<ret><a-i><space>'
}

define-command -hidden select_numbers %{
  execute-keys 's\d+<ret><a-i>n'
}

define-command -hidden select_arguments %{
  execute-keys 's\(<ret><a-i>bs\w+<ret><a-i>u'
}

map -docstring 'regex matches' global select / ':select_regex_matches<ret>'

map -docstring 'inner parenthesis blocks' global select b ':select_inner_parenthesis_blocks<ret>'
map -docstring 'whole parenthesis blocks' global select <a-b> ':select_whole_parenthesis_blocks<ret>'
map -docstring 'inner parenthesis blocks' global select ( ':select_inner_parenthesis_blocks<ret>'
map -docstring 'whole parenthesis blocks' global select ) ':select_whole_parenthesis_blocks<ret>'

map -docstring 'inner brace blocks' global select B ':select_inner_brace_blocks<ret>'
map -docstring 'whole brace blocks' global select <a-B> ':select_whole_brace_blocks<ret>'
map -docstring 'inner brace blocks' global select { ':select_inner_brace_blocks<ret>'
map -docstring 'whole brace blocks' global select } ':select_whole_brace_blocks<ret>'

map -docstring 'inner bracket blocks' global select r ':select_inner_bracket_blocks<ret>'
map -docstring 'whole bracket blocks' global select <a-r> ':select_whole_bracket_blocks<ret>'
map -docstring 'inner bracket blocks' global select [ ':select_inner_bracket_blocks<ret>'
map -docstring 'whole bracket blocks' global select ] ':select_whole_bracket_blocks<ret>'

map -docstring 'inner angle blocks' global select a ':select_inner_angle_blocks<ret>'
map -docstring 'whole angle blocks' global select <a-a> ':select_whole_angle_blocks<ret>'
map -docstring 'inner angle blocks' global select <lt> ':select_inner_angle_blocks<ret>'
map -docstring 'whole angle blocks' global select <gt> ':select_whole_angle_blocks<ret>'

map -docstring 'inner double quote strings' global select Q ':select_inner_double_quote_strings<ret>'
map -docstring 'whole double quote strings' global select <a-Q> ':select_whole_double_quote_strings<ret>'
map -docstring 'inner double quote strings' global select '"' ':select_inner_double_quote_strings<ret>'
map -docstring 'whole double quote strings' global select '<a-">' ':select_whole_double_quote_strings<ret>'

map -docstring 'inner single quote strings' global select q ':select_inner_single_quote_strings<ret>'
map -docstring 'whole single quote strings' global select <a-q> ':select_whole_single_quote_strings<ret>'
map -docstring 'inner single quote strings' global select "'" ':select_inner_single_quote_strings<ret>'
map -docstring 'whole single quote strings' global select "<a-'>" ':select_whole_single_quote_strings<ret>'

map -docstring 'inner grave quote strings' global select g ':select_inner_grave_quote_strings<ret>'
map -docstring 'whole grave quote strings' global select <a-g> ':select_whole_grave_quote_strings<ret>'
map -docstring 'inner grave quote strings' global select ` ':select_inner_grave_quote_strings<ret>'
map -docstring 'whole grave quote strings' global select <a-`> ':select_whole_grave_quote_strings<ret>'

map -docstring 'words' global select w ':select_words<ret>'
map -docstring 'long words' global select <a-w> ':select_long_words<ret>'
map -docstring 'sentences' global select s ':select_sentences<ret>'
map -docstring 'paragraphs' global select p ':select_paragraphs<ret>'
map -docstring 'whitespaces' global select <space> ':select_whitespaces<ret>'
map -docstring 'indent' global select i ':select_indent<ret>'
map -docstring 'numbers' global select n ':select_numbers<ret>'
map -docstring 'arguments' global select u ':select_arguments<ret>'
