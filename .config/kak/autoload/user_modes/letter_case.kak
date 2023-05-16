# Implementation reference: https://docs.rs/inflections/latest/src/inflections/case.rs.html
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

define-command convert_selected_words_to_camel_case_style %{
  iterate_selected_words %{
    execute-keys 's[_-]<ret>d~'
  }
}

define-command convert_selected_words_to_kebab_case_style %{
  iterate_selected_words %{
    swap_word_separator_in_selections '-'
    break_camel_case_in_selections '-'
    convert_selected_text_to_lowercase
  }
}

define-command convert_selected_words_to_snake_case_style %{
  iterate_selected_words %{
    swap_word_separator_in_selections '_'
    break_camel_case_in_selections '_'
    convert_selected_text_to_lowercase
  }
}

define-command iterate_selected_words -params .. %{
  evaluate-commands -draft -verbatim try %{
    execute-keys 's\w[\w-]*<ret>'
    evaluate-commands -itersel -verbatim try %arg{@}
  }
}

define-command break_camel_case_in_selections -params 1 %{
  evaluate-commands -save-regs 'a' -draft -verbatim try %{
    set-register a %arg{1}
    execute-keys 'S\A[A-Z]*<ret>'
    execute-keys 's[_-]?[A-Z]+<ret>`<a-:><a-;>;'
    try %{
      execute-keys -draft '<a-k>[_-]<ret>d'
    }
    execute-keys '"aP'
  }
}

define-command swap_word_separator_in_selections -params 1 %{
  evaluate-commands -save-regs 'a' -draft -verbatim try %{
    set-register a %arg{1}
    execute-keys 's[_-]<ret>"aR'
  }
}

map -docstring 'uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'uppercase' global letter_case '~' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'lowercase' global letter_case '`' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'
map -docstring 'camel_case' global letter_case 'c' ':convert_selected_words_to_camel_case_style<ret>'
map -docstring 'kebab_case' global letter_case 'k' ':convert_selected_words_to_kebab_case_style<ret>'
map -docstring 'kebab_case' global letter_case '<minus>' ':convert_selected_words_to_kebab_case_style<ret>'
map -docstring 'snake_case' global letter_case 's' ':convert_selected_words_to_snake_case_style<ret>'
map -docstring 'snake_case' global letter_case '_' ':convert_selected_words_to_snake_case_style<ret>'
