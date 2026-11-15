def rm %{
  eval %sh{
    rm -- "$kak_buffile" ||
    echo "abort 'rm' '$?'"
  }
  delete-buffer!
}

def -hidden rm_f %{
  eval %sh{
    rm -f -- "$kak_buffile" ||
    echo "abort 'rm' '$?'"
  }
  delete-buffer!
}

alias g rm! rm_f
