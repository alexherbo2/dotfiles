declare-option str inserted_characters

define-command add_insert_chars_user_hook -params 1 %{
  hook %arg{1} ModeChange 'push:normal:insert' %{
    hook -group InsertChars -always window InsertChar .* %{
      set-option -add window inserted_characters %val{hook_param}
      trigger-user-hook "InsertChars=%opt{inserted_characters}"
    }

    hook -group InsertChars -always window InsertMove .* %{
      unset-option window inserted_characters
    }

    hook -group InsertChars -always window ModeChange 'pop:insert:normal' %{
      unset-option window inserted_characters
      remove-hooks window InsertChars
    }
  }
}
