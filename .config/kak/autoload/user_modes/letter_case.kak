declare-user-mode letter_case

define-command enter_letter_case_mode %{
  enter-user-mode letter_case
}

define-command convert_selected_text_to_uppercase %{
  execute-keys '~'
}

define-command convert_selected_text_to_lowercase %{
  execute-keys '`'
}

define-command convert_selected_text_to_title_case %{
  execute-keys -draft 's\w+<ret>`<a-:><a-;>;~'
}

map -docstring 'uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'
map -docstring 'camel_case' global letter_case 'c' ':enter_camel_case_style_mode<ret>'
map -docstring 'kebab_case' global letter_case 'k' ':enter_kebab_case_style_mode<ret>'
map -docstring 'snake_case' global letter_case 's' ':enter_snake_case_style_mode<ret>'
