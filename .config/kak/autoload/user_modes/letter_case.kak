declare-user-mode letter_case
declare-user-mode camel_case_style
declare-user-mode kebab_case_style
declare-user-mode snake_case_style

define-command enter_letter_case_mode %{
  enter-user-mode letter_case
}

define-command enter_camel_case_style_mode %{
  enter-user-mode camel_case_style
}

define-command enter_kebab_case_style_mode %{
  enter-user-mode kebab_case_style
}

define-command enter_snake_case_style_mode %{
  enter-user-mode snake_case_style
}

define-command convert_selected_text_to_uppercase %{
  execute-keys '~'
}

define-command convert_selected_text_to_lowercase %{
  execute-keys '`'
}

define-command convert_selected_text_from_snake_case_style_to_camel_case_style %{
  execute-keys -draft 's_<ret>d~'
}

define-command convert_selected_text_from_snake_case_style_to_kebab_case_style %{
  execute-keys -draft 's_<ret>r-'
}

define-command convert_selected_text_from_camel_case_style_to_snake_case_style %{
  execute-keys -draft 's[A-Z]+<ret>`1<a-,>i_<esc>'
}

define-command convert_selected_text_from_camel_case_style_to_kebab_case_style %{
  execute-keys -draft 's[A-Z]<ret>`i-<esc>'
}

define-command convert_selected_text_from_kebab_case_style_to_camel_case_style %{
  execute-keys -draft 's-<ret>d~'
}

define-command convert_selected_text_from_kebab_case_style_to_snake_case_style %{
  execute-keys -draft 's-<ret>r_'
}

define-command convert_selected_text_to_title_case %{
  execute-keys -draft 's\w+<ret>`<a-:><a-;>;~'
}

map -docstring 'uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'camel_case_style_mode' global letter_case 'c' ':enter_camel_case_style_mode<ret>'
map -docstring 'kebab_case_style_mode' global letter_case 'k' ':enter_kebab_case_style_mode<ret>'
map -docstring 'snake_case_style_mode' global letter_case 's' ':enter_snake_case_style_mode<ret>'
map -docstring 'title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'

map -docstring 'snake_case_style' global camel_case_style 's' ':convert_selected_text_from_snake_case_style_to_camel_case_style<ret>'
map -docstring 'kebab_case_style' global camel_case_style 'k' ':convert_selected_text_from_kebab_case_style_to_camel_case_style<ret>'

map -docstring 'camel_case_style' global snake_case_style 'c' ':convert_selected_text_from_camel_case_style_to_snake_case_style<ret>'
map -docstring 'kebab_case_style' global snake_case_style 'k' ':convert_selected_text_from_kebab_case_style_to_snake_case_style<ret>'

map -docstring 'snake_case_style' global kebab_case_style 's' ':convert_selected_text_from_snake_case_style_to_kebab_case_style<ret>'
map -docstring 'camel_case_style' global kebab_case_style 'c' ':convert_selected_text_from_camel_case_style_to_kebab_case_style<ret>'
