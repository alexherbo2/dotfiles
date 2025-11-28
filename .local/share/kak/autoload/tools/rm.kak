def rm %{
  eval %sh{
    rm -- "$kak_buffile" ||
    printf "fail 'ERROR: rm exited with: %d.'" "$?"
  }
  delete-buffer!
}
