declare-user-mode camel_case_style

define-command enter_camel_case_style_mode %{
  enter-user-mode camel_case_style
}

define-command convert_selected_text_from_snake_case_style_to_camel_case_style %{
  execute-keys -draft 's_<ret>d~'
}

define-command convert_selected_text_from_kebab_case_style_to_camel_case_style %{
  execute-keys -draft 's-<ret>d~'
}

map -docstring 'snake_case_style' global camel_case_style 's' ':convert_selected_text_from_snake_case_style_to_camel_case_style<ret>'
map -docstring 'kebab_case_style' global camel_case_style 'k' ':convert_selected_text_from_kebab_case_style_to_camel_case_style<ret>'
