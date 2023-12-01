# Vim-like unimpaired mappings
declare-user-mode unimpaired_left

define-command enter_unimpaired_left_mode %{
  enter-user-mode unimpaired_left
}

define-command enter_sticky_unimpaired_left_mode %{
  enter-user-mode -lock unimpaired_left
}

define-command hide_line_numbers %{
  add-highlighter global/line_numbers number-lines -hlcursor
}

define-command disable_readonly_mode %{
  set-option global readonly no
}

define-command remove_whitespace_rendering %{
  remove-highlighter global/render_whitespace
}

define-command remove_rulers %{
  remove-highlighter global/rulers
}

define-command disable_soft_wrap %{
  remove-highlighter global/soft_wrap
}

map -docstring 'line numbers' global unimpaired_left l ':hide_line_numbers<ret>'
map -docstring 'render whitespace' global unimpaired_left w ':remove_whitespace_rendering<ret>'
map -docstring 'read-only' global unimpaired_left r ':disable_readonly_mode<ret>'
map -docstring 'soft-wrap' global unimpaired_left <tab> ':disable_soft_wrap<ret>'
map -docstring 'rulers' global unimpaired_left | ':remove_rulers<ret>'
map -docstring 'space' global unimpaired_left <space> <a-O>
map -docstring 'buffer' global unimpaired_left b ':buffer-previous<ret>'

map -docstring 'jump to previous reference' global unimpaired_left g ':jump_to_previous_reference<ret>'
map -docstring 'jump to first reference' global unimpaired_left G ':jump_to_first_reference<ret>'

map -docstring 'jump to previous file' global unimpaired_left f ':jump_to_previous_file<ret>'
map -docstring 'jump to first file' global unimpaired_left F ':jump_to_first_file<ret>'
