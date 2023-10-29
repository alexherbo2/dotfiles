define-command add_insert_chars_user_hook %{
  hook global InsertChar .* %{
    hook -group InsertChars window InsertChar .* %exp{
      remove-hooks window InsertChars
      trigger-user-hook "InsertChars=%val{hook_param}%%val{hook_param}"
    }
    hook -group InsertChars window InsertMove .* %{
      remove-hooks window InsertChars
    }
    hook -group InsertChars window ModeChange .* %{
      remove-hooks window InsertChars
    }
  }
}
