def git-mv -params 1 %{
  eval %sh{
    git mv -- "$kak_buffile" "$1" ||
    echo "abort 'git-mv' '$?'"
  }
  rename-buffer -- %arg{1}
}

compl git-mv file
