define-command rm %{
  evaluate-commands %sh{
    rm -- "$kak_buffile" ||
    printf "fail 'ERROR: rm exited with: %d.'" "$?"
  }
  delete-buffer!
}
