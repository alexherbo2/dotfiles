# Vim-like unimpaired mappings
declare-user-mode unimpaired_right

define-command enter_unimpaired_right_mode %{
  enter-user-mode unimpaired_right
}

define-command show_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command enable_readonly_mode %{
  set-option buffer readonly yes
}

define-command render_whitespace %{
  add-highlighter global/render_whitespace show-whitespaces
}

define-command add_rulers %{
  add-highlighter global/rulers column 81 default,cyan
}

define-command enable_soft_wrap %{
  add-highlighter global/soft_wrap wrap -indent -marker '↪'
}

map -docstring 'line numbers' global unimpaired_right l ':show_line_numbers<ret>'
map -docstring 'render whitespace' global unimpaired_right w ':render_whitespace<ret>'
map -docstring 'soft-wrap' global unimpaired_right <tab> ':enable_soft_wrap<ret>'
map -docstring 'read-only' global unimpaired_right r ':enable_readonly_mode<ret>'
map -docstring 'rulers' global unimpaired_right | ':add_rulers<ret>'
map -docstring 'space' global unimpaired_right <space> <a-o>
map -docstring 'buffer' global unimpaired_right b ':buffer-next<ret>'
