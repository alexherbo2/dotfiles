# Implementation reference: https://docs.rs/inflections/latest/src/inflections/case.rs.html
define-command convert_selected_text_to_uppercase %{
  execute-keys '~'
}

define-command convert_selected_text_to_lowercase %{
  execute-keys '`'
}

define-command convert_selected_text_to_title_case %{
  iterate_selected_words %{
    execute-keys '`<a-:><a-;>;~'
  }
}

define-command convert_selected_words_to_camel_case_style %{
  iterate_selected_words %{
    join_camel_case_in_selections
  }
}

define-command convert_selected_words_to_pascal_case_style %{
  iterate_selected_words %{
    execute-keys -draft '<a-:><a-;>;~'
    join_camel_case_in_selections
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

define-command join_camel_case_in_selections %{
  execute-keys 's[_-]<ret>d~'
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
