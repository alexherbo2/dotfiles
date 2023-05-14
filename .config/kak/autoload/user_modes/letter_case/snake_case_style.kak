declare-user-mode snake_case_style

define-command enter_snake_case_style_mode %{
  enter-user-mode snake_case_style
}

define-command convert_selected_text_from_camel_case_style_to_snake_case_style %{
  execute-keys -draft 's[A-Z]+<ret>`i_<esc>'
}

define-command convert_selected_text_from_kebab_case_style_to_snake_case_style %{
  execute-keys -draft 's-<ret>r_'
}

map -docstring 'camel_case_style' global snake_case_style 'c' ':convert_selected_text_from_camel_case_style_to_snake_case_style<ret>'
map -docstring 'kebab_case_style' global snake_case_style 'k' ':convert_selected_text_from_kebab_case_style_to_snake_case_style<ret>'
