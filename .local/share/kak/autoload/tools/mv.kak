def mv -params 1 %{
  eval %sh{
    mv -- "$kak_buffile" "$1" ||
    echo "abort 'mv' '$?'"
  }
  rename-buffer -- %arg{1}
}

compl mv file
