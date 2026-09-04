def rm %{
  eval %sh{
    rm -- "$kak_buffile" ||
    echo "abort 'rm' '$?'"
  }
  delete-buffer!
}
