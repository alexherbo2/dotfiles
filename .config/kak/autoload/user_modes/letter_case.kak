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
  execute-keys -draft 's\w+<ret><a-:><a-;>;~'
}

map -docstring 'to_uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'to_lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'from_snake_case_style_to_camel_case_style' global letter_case 'c' ':convert_selected_text_from_snake_case_style_to_camel_case_style<ret>'
map -docstring 'from_snake_case_style_to_kebab_case_style' global letter_case 'k' ':convert_selected_text_from_snake_case_style_to_kebab_case_style<ret>'
map -docstring 'from_camel_case_style_to_snake_case_style' global letter_case 's' ':convert_selected_text_from_camel_case_style_to_snake_case_style<ret>'
map -docstring 'from_kebab_case_style_to_snake_case_style' global letter_case '_' ':convert_selected_text_from_kebab_case_style_to_snake_case_style<ret>'
map -docstring 'to_title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'
