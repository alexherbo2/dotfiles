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
  evaluate-commands -draft -verbatim try %{
    # Select long words before iterating.
    execute-keys 's[\w-]+<ret>'

    evaluate-commands -itersel -verbatim try %{
      # Convert selected text from snake case or kebab case style to camel case style.
      execute-keys 's[_-]<ret>d~'
    }
  }
}

define-command convert_selected_words_to_kebab_case_style %{
  evaluate-commands -draft -verbatim try %{
    # Select long words before iterating.
    execute-keys 's[\w-]+<ret>'

    evaluate-commands -itersel -verbatim try %{
      # Convert selected text from snake case style to kebab case style.
      try %{
        execute-keys -draft 's_<ret>r-'
      }
      # Convert selected text from camel case to kebab case style.
      try %{
        execute-keys -draft 's[A-Z]+<ret>`i-<esc>'
      }
    }
  }
}

define-command convert_selected_words_to_snake_case_style %{
  evaluate-commands -draft -verbatim try %{
    # Select long words before iterating.
    execute-keys 's\w[\w-]*<ret>'

    evaluate-commands -itersel -verbatim try %{
      # Convert selected text from kebab case style to snake case style.
      try %{
        execute-keys -draft 's-<ret>r_'
      }
      # Convert selected text from camel case to snake case style.
      evaluate-commands -draft -verbatim try %{
        execute-keys 'S\A[A-Z]*<ret>'
        execute-keys 's_?[A-Z]+<ret>`<a-:><a-;>;'
        try %{
          execute-keys -draft '<a-k>_<ret>d'
        }
        execute-keys 'i_<esc>'
      }
    }
  }
  execute-keys '`'
}

map -docstring 'uppercase' global letter_case 'u' ':convert_selected_text_to_uppercase<ret>'
map -docstring 'lowercase' global letter_case 'l' ':convert_selected_text_to_lowercase<ret>'
map -docstring 'title_case' global letter_case 't' ':convert_selected_text_to_title_case<ret>'
map -docstring 'camel_case' global letter_case 'c' ':convert_selected_words_to_camel_case_style<ret>'
map -docstring 'kebab_case' global letter_case 'k' ':convert_selected_words_to_kebab_case_style<ret>'
map -docstring 'snake_case' global letter_case 's' ':convert_selected_words_to_snake_case_style<ret>'
