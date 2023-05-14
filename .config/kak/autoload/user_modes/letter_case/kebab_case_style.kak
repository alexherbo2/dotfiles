declare-user-mode kebab_case_style

define-command enter_kebab_case_style_mode %{
  enter-user-mode kebab_case_style
}

define-command convert_selected_text_from_snake_case_style_to_kebab_case_style %{
  execute-keys -draft 's_<ret>r-'
}

define-command convert_selected_text_from_camel_case_style_to_kebab_case_style %{
  execute-keys -draft 's[A-Z]+<ret>`i-<esc>'
}

map -docstring 'snake_case_style' global kebab_case_style 's' ':convert_selected_text_from_snake_case_style_to_kebab_case_style<ret>'
map -docstring 'camel_case_style' global kebab_case_style 'c' ':convert_selected_text_from_camel_case_style_to_kebab_case_style<ret>'
