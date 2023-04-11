# Text objects

# Options ──────────────────────────────────────────────────────────────────────

# Matching pairs
set-option global matching_pairs ( ) { } [ ] < > “ ” ‘ ’ « » ‹ ›

# Mappings ─────────────────────────────────────────────────────────────────────

# Quotation marks
map -docstring 'double quotation mark' global object <a-Q> 'c“,”<ret>'
map -docstring 'single quotation mark' global object <a-q> 'c‘,’<ret>'
map -docstring 'double angle quotation mark' global object <a-G> 'c«,»<ret>'
map -docstring 'single angle quotation mark' global object <a-g> 'c‹,›<ret>'

# Tag
map -docstring 'tag' global object t 'c<lt>.+?<gt>,<lt>/.+?<gt><ret>'

# Line
map -docstring 'line' global object x '<esc>x_'

# Extended next and previous pairs
map -docstring 'previous parenthesis block' global object ( '<a-;> select-previous-parenthesis-block<ret>'
map -docstring 'next parenthesis block' global object ) '<a-;> select-next-parenthesis-block<ret>'

map -docstring 'previous brace block' global object { '<a-;> select-previous-brace-block<ret>'
map -docstring 'next brace block' global object } '<a-;> select-next-brace-block<ret>'

map -docstring 'previous bracket block' global object [ '<a-;> select-previous-bracket-block<ret>'
map -docstring 'next bracket block' global object ] '<a-;> select-next-bracket-block<ret>'

map -docstring 'previous angle block' global object <lt> '<a-;> select-previous-angle-block<ret>'
map -docstring 'next angle block' global object <gt> '<a-;> select-next-angle-block<ret>'

map -docstring 'next double quote string' global object '"' '<a-;> select-next-double-quote-string<ret>'
map -docstring 'previous double quote string' global object '<a-">' '<a-;> select-previous-double-quote-string<ret>'

map -docstring 'next single quote string' global object "'" '<a-;> select-next-single-quote-string<ret>'
map -docstring 'previous single quote string' global object "<a-'>" '<a-;> select-previous-single-quote-string<ret>'

map -docstring 'next grave quote string' global object ` '<a-;> select-next-grave-quote-string<ret>'
map -docstring 'previous grave quote string' global object <a-`> '<a-;> select-previous-grave-quote-string<ret>'

# Commands ─────────────────────────────────────────────────────────────────────

define-command -override -hidden select-next-parenthesis-block -docstring 'select next parenthesis block' %{
  execute-keys "f(%opt{object_key}b"
}

define-command -override -hidden select-previous-parenthesis-block -docstring 'select previous parenthesis block' %{
  execute-keys "<a-f>(%opt{object_key}b"
}

define-command -override -hidden select-next-brace-block -docstring 'select next brace block' %{
  execute-keys "f{%opt{object_key}B" # }
}

define-command -override -hidden select-previous-brace-block -docstring 'select previous brace block' %{
  execute-keys "<a-f>{%opt{object_key}B" # }
}

define-command -override -hidden select-next-bracket-block -docstring 'select next bracket block' %{
  execute-keys "f[%opt{object_key}r"
}

define-command -override -hidden select-previous-bracket-block -docstring 'select previous bracket block' %{
  execute-keys "<a-f>[%opt{object_key}r"
}

define-command -override -hidden select-next-angle-block -docstring 'select next angle block' %{
  execute-keys "f<lt>%opt{object_key}a"
}

define-command -override -hidden select-previous-angle-block -docstring 'select previous angle block' %{
  execute-keys "<a-f><lt>%opt{object_key}a"
}

define-command -override -hidden select-next-double-quote-string -docstring 'select next double quote string' %{
  execute-keys "f""%opt{object_key}Q"
}

define-command -override -hidden select-previous-double-quote-string -docstring 'select previous double quote string' %{
  execute-keys "<a-f>""h%opt{object_key}Q"
}

define-command -override -hidden select-next-single-quote-string -docstring 'select next single quote string' %{
  execute-keys "f'%opt{object_key}q"
}

define-command -override -hidden select-previous-single-quote-string -docstring 'select previous single quote string' %{
  execute-keys "<a-f>'h%opt{object_key}q"
}

define-command -override -hidden select-next-grave-quote-string -docstring 'select next grave quote string' %{
  execute-keys "f`%opt{object_key}g"
}

define-command -override -hidden select-previous-grave-quote-string -docstring 'select previous grave quote string' %{
  execute-keys "<a-f>`h%opt{object_key}g"
}

# Expose object key.
# Implementation reference: https://github.com/mawww/kakoune/blob/master/src/normal.cc#:~:text=select_object
declare-option -hidden str object_key
remove-hooks global object-key
hook -group object-key -always global NormalKey '<a-i>|<a-a>|\[|\]|\{|\}|<a-\[>|<a-\]>|<a-\{>|<a-\}>' %{
  set-option window object_key %val{hook_param}
}
