# Example configuration:
# map -docstring 'enter word jump replace mode' global normal f ':enter_word_jump_replace_mode<ret>'
# map -docstring 'enter word jump extend mode' global normal F ':enter_word_jump_extend_mode<ret>'
# map -docstring 'enter word jump append mode' global normal <a-F> ':enter_word_jump_append_mode<ret>'

define-command enter_word_jump_replace_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_replace_mode
}

define-command enter_word_jump_extend_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_extend_mode
}

define-command enter_word_jump_append_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_append_mode
}

define-command create_jump_state_from_words_in_viewport %{
  create_jump_state_from_selections_in_viewport %{
    execute-keys 's\w+<ret><a-i>w'
  }
}
