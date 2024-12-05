# Implementation reference: https://docs.rs/inflections/latest/src/inflections/case.rs.html
declare-user-mode letter_case

define-command enter_letter_case_mode %{
  enter-user-mode letter_case
}

map -docstring 'uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'uppercase' global letter_case '~' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'lowercase' global letter_case '`' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'
map -docstring 'title_case' global letter_case '.' ':convert_selected_text_to_title_case<ret>'
map -docstring 'camel_case' global letter_case 'c' ':convert_selected_words_to_camel_case_style<ret>'
map -docstring 'pascal_case' global letter_case 'p' ':convert_selected_words_to_pascal_case_style<ret>'
map -docstring 'kebab_case' global letter_case 'k' ':convert_selected_words_to_kebab_case_style<ret>'
map -docstring 'kebab_case' global letter_case '<minus>' ':convert_selected_words_to_kebab_case_style<ret>'
map -docstring 'snake_case' global letter_case 's' ':convert_selected_words_to_snake_case_style<ret>'
map -docstring 'snake_case' global letter_case '_' ':convert_selected_words_to_snake_case_style<ret>'
