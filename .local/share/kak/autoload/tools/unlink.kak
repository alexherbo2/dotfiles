def unlink %{
  eval %sh{
    unlink -- "$kak_buffile" ||
    echo "abort 'unlink' '$?'"
  }
}
