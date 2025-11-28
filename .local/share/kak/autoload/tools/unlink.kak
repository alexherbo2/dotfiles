def unlink %{
  eval %sh{
    unlink -- "$kak_buffile" ||
    printf "fail 'ERROR: unlink exited with: %d.'" "$?"
  }
}
