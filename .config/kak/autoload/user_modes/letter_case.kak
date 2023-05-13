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
  execute-keys -draft 's[A-Z]<ret>`i_<esc>'
}

define-command convert_selected_text_to_title_case %{
  execute-keys -draft 's\w+<ret><a-:><a-;>;~'
}
