def mkdir %{
  eval %sh{
    mkdir -p -- "$(dirname -- "$kak_buffile")" ||
    echo "abort 'mkdir' '$?'"
  }
}
