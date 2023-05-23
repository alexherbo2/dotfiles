# Vim-like unimpaired mappings
declare-user-mode unimpaired_left

define-command enter_unimpaired_left_mode %{
  enter-user-mode unimpaired_left
}

define-command hide_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command disable_readonly_mode %{
  set-option global readonly yes
}

define-command remove_whitespace_rendering %{
  add-highlighter global/render_whitespace show-whitespaces
}

define-command remove_rulers %{
  add-highlighter global/rulers column 81 default,cyan
}

define-command disable_soft_wrap %{
  add-highlighter global/soft_wrap wrap -indent -marker '↪'
}

map -docstring 'line numbers' global unimpaired_left l ':hide_line_numbers<ret>'
map -docstring 'render whitespace' global unimpaired_left w ':remove_whitespace_rendering<ret>'
map -docstring 'read-only' global unimpaired_left r ':disable_readonly_mode<ret>'
map -docstring 'soft-wrap' global unimpaired_left <tab> ':disable_soft_wrap<ret>'
map -docstring 'rulers' global unimpaired_left | ':remove_rulers<ret>'