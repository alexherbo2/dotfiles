define-command unlink %{
  evaluate-commands %sh{
    unlink -- "$kak_buffile" ||
    printf "fail 'ERROR: unlink exited with: %d.'" "$?"
  }
}
