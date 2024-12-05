# name: kakoune_select_mode
# version: 0.1.0
# description: This script provides the functionality to subselect text objects.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
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
